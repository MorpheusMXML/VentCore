import './App.css';
import React, {useEffect, useState} from 'react';
import useInterval from '@use-it/interval';
import firebase from "./firebase";
import {v4 as uuidV4} from 'uuid';
import Plot from 'react-plotly.js';

const App = () => {
  const firebaseRef = firebase.firestore().collection("patients");

  const [patients, setPatients] = useState([{heartFrequency: 0, spO2: 0}]);
  const [loading, setLoading] = useState(false);
  const [counter, setCounter] = useState(0);

  const [heartFreq, setHeartFreq] = useState([...new Array(30)].map(() => 0));
  const [oxySat, setOxySat] = useState([...new Array(30)].map(() => 0));
  const [xAxis, setXAxis] = useState([...new Array(30)].map(() => new Date()));

  const [currentHeartFreq, setCurrentHeartFreq] = useState(0);
  const [currentOxySat, setCurrentOxySat] = useState(0);

  const [heartFreqPhase, setHeartFreqPhase] = useState(0);
  const [oxySatPhase, setOxySatPhase] = useState(0);

  // Read data from firebase
  const getPatients = () => {
    setLoading(true);
    firebaseRef.onSnapshot((querySnapshot) => {
      const items = [];
      querySnapshot.forEach((doc) => {
        items.push(doc.data());
      });
      setPatients(items);
      setLoading(false);
    })
  }

  // Add patient
  const addPatient = (newPatient) => {
    firebaseRef
      .doc(newPatient.id)
      .set(newPatient)
      .catch((err) => {
        console.log(err);
      });
  }

  // Delete patient
  const deletePatient = (patient) => {
    firebaseRef
      .doc(patient.id)
      .delete()
      .catch((err) => {
        console.log(err);
      });
  }

  // Update patient
  const updatePatient = (updatedPatient) => {
    firebaseRef
      .doc(updatedPatient.id)
      .update(updatedPatient)
      .catch((err) => {
        console.log(err);
      });
  }

  // generate random values for HF and SpO2 every second
  useInterval(() => {
    const randomO2 = Math.round(Math.random() * 5);
    const randomHF = Math.round(Math.random() * 10);

    let HF;
    let O2;

    switch (heartFreqPhase) {
      case(1):
        HF = 70 + randomHF;
        break;
      case(2):
        HF = 30 + randomHF;
        break;
      case(3):
        HF = 120 + randomHF;
        break;
      case(4):
        HF = 30 + randomHF;
        break;
      case(5):
        HF = 70 + randomHF;
        break;
      case(6):
        HF = 50 + randomHF;
        break;
      default:
        HF = 50 + randomHF;
        break;
    }

    switch (oxySatPhase) {
      case(1):
        O2 = 98 + randomO2;
        break;
      case(2):
        O2 = 96 + randomO2;
        break;
      case(3):
        O2 = 92 + randomO2;
        break;
      default:
        O2 = 90 + randomO2;
        break;
    }

    setHeartFreqPhase((heartFreqPhase + 1) % 9);
    setOxySatPhase((oxySat + 1) % 4);

    setHeartFreq(heartFreq.slice(1).concat(HF));
    setOxySat(oxySat.slice(1).concat(randomO2));
    setXAxis(xAxis.slice(1).concat(new Date()));

    updatePatient({
      id: "1",
      heartFrequency: HF,
      spO2: O2
    });
  }, 1000);

  // render on change
  useEffect(() => {
    getPatients();
  }, []);

  // draw a Plotly graph
  const drawGraph = (x, y, color, title, headline, currentVal) => {
    return (
      <>
        <Plot
          data={[{
            x: x,
            y: y,
            type: 'scatter',
            mode: 'lines+markers',
            marker: {color: color},
            line: {shape: 'spline'}
          }]}
          layout={{width: 1000, height: 600, title: title}}
          config={{'displayModeBar': false}}
        />
        <div className='current-val'> {headline} <br/> {currentVal} </div>
      </>)
  }

  if (loading) {
    return <h1>Loading...</h1>
  }

  return (
    <>
      <div className='container'>
        <h1>Patients</h1>
        <div className='inputBox'>
          <div>
            <span>Heart Frequency</span>
            <input onChange={(e) => setCurrentHeartFreq(e.target.value)}/>
          </div>
          <div>
            <span>Oxygen Saturation</span>
            <input onChange={(e) => setCurrentOxySat(e.target.value)}/>
          </div>
          <button onClick={() => {
            setCounter(counter + 1);
            addPatient({
              heartFrequency: currentHeartFreq,
              spO2: currentOxySat,
              age: 30,
              sex: 'male',
              id: uuidV4()
            });
          }}>
            Add new patient
          </button>
        </div>
        <hr/>

        {React.Children.toArray(
          patients.map((patient) => (
            <div className="patient">
              <h2>patient id: {patient.id}</h2>
              <div>
                <button onClick={() => deletePatient(patient)}>Delete</button>
                <button onClick={() => updatePatient({
                  id: patient.id,
                  heartFrequency: currentHeartFreq,
                  spO2: currentOxySat
                })}>Update
                </button>
              </div>
            </div>
          )))}

        <div className='plot'>
          {drawGraph(xAxis, heartFreq, "red", "Heart Frequency of Patient 1", "HF", patients[0].heartFrequency)}
        </div>

        <div className='plot'>
          {drawGraph(xAxis, oxySat, "blue", "Oxygen Saturation of Patient 1", "SpO2", patients[0].spO2)}
        </div>
      </div>
    </>
  );
}

export default App;
