
<div  align="justify"  style="font-family: Jura">

# Alarm Logic
The main approach for the alarm management is to support the user and to prevent a sensory overload. Furthermore, it is the aim to update the user on current changes and to display the actual condition of a patient. For the M-Lab project and the future 3-in-1 device, sounds are coming only from one device which is why the logic needs to follow predefined rules. Those rules and the resulting behaviour should cover (at best) every possible case of upcoming alarms. The following assumptions were made with respect to the app and can diverge from the finished 3-in-1 device.

1. The system needs to prioritize alarms.

2. The system should always visualize alarms.

3. The system should display the current patient condition with alarms and the most updated system state on the screen.

4. The system should display an alarm at least 15 seconds before turning into a lower alarm for communicating the user, that there has been a higher alarm before.

5. The system should only play one alarm at once, even when more alarms are occurring.

6. The system should only play audio with the highest priority.

7. The system should not play alarms in defibrillation mode.

8. The system should mute alarms after leaving the defibrillation mode for one minute after switching into ventilation mode and for 30 seconds after switching into monitoring mode.

9. The system should distinguish higher and middle alerts.

10. The playback frequency for high alerts should be higher than for middle alerts.

11. The system should offer the ability to adjust boundaries in a smart way when a middle alert is triggered 3 times in a row without being interrupted by higher or different alarms.

12. An alarm from a specific sensor should not occur for one minute after confirming it.

13. A confirmed sensor should play alarms when the upcoming alarm is higher than the confirmed alarm.

14. Alarms from monitoring and ventilation sensors should be distinguishable.

15. If alarms are coming from monitoring and ventilation at once with the same priority, the audio should alternate.

# Alarm Priority

With the updated values, the system checks for the priority of the value update and if it’s a middle or high alert or a warning. To check the priority, every sensor has a predefined `SensorDeviation`. The `SensorDeviation` describes the range of allowed values above or below a limit before an alarm is classified as high.

```shell

Sensor: Heartfrequency

Upper Boundary: 120

Lower Boundaray: 50

SensorDeviation: 0.1 (10%)

middle alert upper boundary: if (newValue < 120 * 1.1)

high alert upper boundary: if (newValue >= 120 * 1.1)

middle alert lower boundary: if (newValue > 50 * 0.9)

high alert upper boundary: if (newValue <= 50 * 0.9)

```
### Examples `SensorDeviation`
| Sensor | Lower Boundary | Upper Boundary | `sensorDeviation` | high alarm lower | high alarm upper |
| ----------- | :-----------: | :-----------: | :-----------: | :-----------: | :-----------: |
|Heartfrequency|50|120|10%|45|132|
|SpO2|90|-|10%|81|-|
|Temperature|36.0|37.9|1%|35.6|38.2|
|CO2|30|45|10%|27|49|

If a value update is whether a high or a middle alert, the system still checks for warnings. Those can occur, when the `ValueDeviation`, the value difference from the current value and the new updated value, is higher than allowed. This can for example also happen when the updated value is in the boundaries of the sensor. The `ValueDeviation`is different for every sensor but calculated with the following formular:

```shell

Sensor: Heartfrequency

Upper Boundary: 120

Lower Boundary: 50

valueDifference = [upperBoundary – lowerBoundary] / 2 = 35

```

The system also needs to check for Zero-Values. This can be an indicator of disconnection of the physical sensor or for a high alert.

# Alarm State

If an alarm is detected the system still needs to check, if it is necessary to throw the alarm and if the sensor is active at the screen. For this, the system holds an alarm state and an `activeAlarmList`.

An alarm state needs to be changed when a new alarm with the same or higher priority and another message occurs. An `alarmMessage` defines the type of the alarm, for example if the upper boundary or if the lower boundary is violated. If a new alarm with a higher priority occurs, the alarms state always needs to be changed to a higher priority.

Another condition that needs be considered is the `confirmState` of an alarm. During a confirm, the sensor should not throw new alarms with the same message, that are the same or lower priority. But if the alarm changes to the worse, the user needs to be informed. Even if we are in the confirm time. More cases are described in the following decisions.
<a href="https://ibb.co/LYz0dRD"><img src="https://i.ibb.co/ckcyh3K/table1.png" alt="table1" border="0" style="width: 100%" /></a>

On the other hand, a confirm state should be ended when the confirm time ends or when the alarm is not necessary anymore. Means the sensor with its new values is back in its boundaries or a higher alarm occurs, which the user needs to be informed about.

<a href="https://ibb.co/rZK0qVg"><img src="https://i.ibb.co/MRySKmb/table2.png" alt="table2" border="0" style="width: 100%"/></a>

# ActiveAlarmList and SoundList
The system state holds a list for all `activeAlarms` and all currently shown sensors on the screen. In addition the `SoundController` holds different `Map`s for sound files. The `soundList` is defined in the `AlarmController` and updated every time the system state updates. The `soundList` is sorted by `priority` and eliminates all alarms that are confirmed or not active anymore with the help of the sytem state. The sorting helps to identfy the sound file for the next step, because the highest priority, which is the first place in the list, decides which sound file is being played. Furthermore the soundlist is still holding all alarms with the same priority which is used for Alarm Affiliation.

# Alarm Affiliation
A sensor belongs to the monitoring or to the ventilation mode. For example, the heartfrequency is a monitoring sensor, while the CO2 sensor belongs to ventilation. As default a sensor belongs to the monitoring mode. The `AlarmController` evaluates which sound file to play. For this, identifying if a monitoring or ventilation alarm file should be used for the alarm sound. If two sensors with different modes should play an alarm with the same priority, the AlarmController decides to play an alternating sound of a monitoring sound file in combination with the ventilation sound file. 

# SoundController

The `SoundController` plays the evaluated sounds of the `AlarmController` and hold the instance of the timer for looping the audio. The frequency of the alarm sound is defined by a `timeDuration`. If the default duration value is `0`, the sound file is playing only once. 

# Alarm Logic in the Context of M-Lab

During implementing the alarm management for the M-Lab application we occurred some problems with the Framework Flutter. We would like to mention, that not all approaches are implemented in the application. Flutter respectively dart has a problem with timers. Timers are not accurate and are sometimes still active after cancelling them. Especially while working with alarm sounds, we experienced timer issues and overlaying of sounds. To avoid this behaviour, alarms are coming delayed and not in the moment an alarm is triggered. Furthermore, delaying an update change of an alarm before it turns into a lower alarm is not implemented and still needs to be solved. The approach for this is to delay an update change of the alarm state if this behaviour is detected. Since the system is working with mocked data, values update a little bit faster and in higher steps a real device would update. This sometimes leads to faster changing alarm states which could be delayed with timers. To avoid upcoming wrong behaviour, the implementation with timer was reduced to a minimum to insure stable application.

The system is able to play the highest alarm sounds for active alarms and to play only one alarm at time. It also changes the visualisation of the current alarm state with colors on the screen. Furthermore it can evaluate the alarm type wether it is coming from monitoring or ventilation sensors. All alarm sounds are selfmaed to convey a new feeling for the application and because the old sound files were not reachable for the M-Lab project.
The user is able to confirm single alarms or all alarms at once. In defibrillation mode all alarms are muted. Switching back to montioring or ventilation enables active alarms again. Upcoming alarms can be confirmed and stay confirmed for a defined time. When the alarm is raising in its priority, the confirm state ends to inform the user about the worse condition that occured. In addition to that, the user gets the offer from the system to "smart adjust boundaries" when a middle alert is occuring three times in a row without being interrupted by a higher alarm or an alarm with another alarm message. If the user accepts this offer, the system adjust the triggered boundary by predefined percentages. This aims to reduce the sensory overload and to support. 
</div>

