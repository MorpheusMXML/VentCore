import firebase from 'firebase/compat/app';
import "firebase/compat/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyBJrBQN1pBbogOQ_2t6hTDWDyj90lLwcYI",
  authDomain: "uke-test-4b866.firebaseapp.com",
  projectId: "uke-test-4b866",
  storageBucket: "uke-test-4b866.appspot.com",
  messagingSenderId: "89849955598",
  appId: "1:89849955598:web:3786c53ba795bc0e48835f",
  measurementId: "G-TWGVDNXFE9"
};

firebase.initializeApp(firebaseConfig);

export default firebase;
