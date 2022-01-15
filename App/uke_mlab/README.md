<div id="top"></div>

<!-- PROJECT SHIELDS -->
TODO COMPLETE
<div align="center">

[![Commits][commit-shield]][commit-url]
[![Issues][issues-shield]][issues-url]
[![Team][team-shield]][team-url]
[![Website][website-shield]][website-url]

</div>



<!-- PROJECT LOGO -->
<br />
<div align="center" style="font-family: Jura">
  <a href="https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202122/uke">
    <img src="./ReadMeFiles/LogoVentCore.png" alt="Logo">
  </a>



<!-- DESCRIPTION -->
<h2>UKE M-Lab </h2>

  <p>
    This is the Repository for the M-Lab Course project VentCore. 
    This Course was held during the WS 2021/2022 by the MAST Team of University of Hamburg

TODO LINKS:
<a href=""><strong>Explore the docs »</strong></a>
<br />
<br />
<a href="">View Trailer</a>
·
<a href="">Visit Website</a>
·
</p>
</div>

***



<!-- TABLE OF CONTENTS -->
<details style="font-family:Jura">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#design">Design</a></li>
    <li><a href="#alarm">Alarm Handling</a></li>
    <li><a href="#dataprocessing">Data Processing</a></li>
    <li><a href="#documentation">Documentation</a></li>
    <li><a href="#known-issues">Known Issues</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

***



<!-- ABOUT THE PROJECT -->
<div align:"Justify" style="font-family:Jura">

# About The Project
TODO SCREENSHOT
![VentCore][product-screenshot]

This is the repository for the UKE M-Lab prototype of VentCore: A Mock-Up for a possible 3-in-1 Medical device which combines a patient Monitoring, Defibrillation and Ventilation.
The App in this repository demonstrates the User-Interface and Alarm-Management for such a device in a Tablet-Application. This Tablet-Application was designed for a 10" Inch Screen with the Flutter SDK to run on both, Android and iOS.

The prototype is build with simulation data designed to mimic real emergency scenarios that where provided by emergency doctors of the [UKE](https://www.uke.de/) and the friendly help of [WEINMANN](https://www.weinmann-emergency.com/de/).

The following sections will guide you through the installation process, documentation and functionalities of the code, the design and [Style Guide](/App/documentation/uke-styleguide-tables.md) used as well as the data used an how it was processed.

<p align="right">(<a href="#top">back to top</a>)</p>

## Built With

As mentioned, this is a Flutter Tablet application written in **dart**. For the Data Processing and creation we used **Python**.

* [Flutter](https://flutter.dev/)
* [Dart](https://dart.dev/)
* [Python](https://www.python.org/)

<p align="right">(<a href="#top">back to top</a>)</p>

***




<!-- GETTING STARTED -->
# Getting Started

To start the Application and Simulate the Scenarios follow the upcoming steps.

## Prerequisites

Please make sure, that you've installed a stable Version of the Flutter SDK. Please consider [this link](https://docs.flutter.dev/get-started/install).

* Verify your working Installation with:

  ```sh
  flutter doctor
  ```

Depending on your operating system make sure to have the simulator(macOS) or Android Emulator(Windows) installed and working.

## Device Recommendations

Since this App was designed with a requirement of a 10" Inch tablet screen with a resolution of 1920x1200 pixels, we recommend to use one of the following emulation devices:

* **macOS**

``` sh
iPad Pro (3rd generation)
iOS Version 15.2
```
+ **Windows**
TODO ANDROID VERSION
```sh
Pixel C 
Android Version 11.0 x86
```

## Installation

1. Clone the repository.
    ```sh
   git clone https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202122/uke
   ```

2. Start the emulator you want to use. [Device Recommendations](#device)

3. Run Application with terminal in the location on your disk:

   ```sh
   flutter run lib/main.dart
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

***



<!-- USAGE EXAMPLES -->
# Usage

This prototype works as showcase for demonstrating and evaluating of a future 3-in-1 interface with simulated data. 
<br>

|TODO SCREENSHOTS||
|---|---|
|Choose Presets|Set Alarm Limits directly|
[StartScreen]|[AlarmLimit]|
|Switch between Modes|Customize the Screen|
|[DefiScreen]|[Add] <br/>[NIBD]|
|Explore Patient Scenarios|Explore Alarm Behaviour|
|[Scenario]|[RedAlarm]<br/>[YellowAlarm]|

##### For more examples, please refer to the [Documentation](TODOLINK)

<p align="right">(<a href="#top">back to top</a>)</p>

***



<!-- DESIGN -->
# Design

For the design created in Figma please follow this link:
* [Design Clickdummy](https://www.figma.com/proto/ase69ABWTPP8L2kVJdHuzq/MLab---UKE-Protoype-UI?node-id=892%3A3234&scaling=scale-down&page-id=892%3A792&starting-point-node-id=892%3A3234&show-proto-sidebar=1)

Also have a look at our StyleGuide for the colors used in the prototype.

* [Style Guide](../documentation/uke-styleguide-tables.md)

<p align="right">(<a href="#top">back to top</a>)</p>

***



<!-- ALARM HANDLING -->
# Alarm Handling
For a complete overview, please refer to our [AlarmLogic.md](TODO LINK)



### Priotising alarms in categories
Parameter alarms are prioritised according to the severity of their deviations from the set alarm limits. The `SensorDeviation` is defined in percent for each parameter.

#### Example:
  ```
  Parameter: Heartfrequency
  Upper Limit: 120
  SensorDeviation: 0.1
  Middle Alert: 120 < currentValue < 131
  High Alert: currentValue >131
  ```



### Auditory alarm according to prioritisation
Alarms are displayed audibly in descending order of priority.
![Table Audio Priorities](./ReadMeFiles/table-audio-priority.png)



### Auditory Behaviour of Alarms



## General Rules

//TODO: Add Description of Alarm Handling Rules
<p align="right">(<a href="#top">back to top</a>)</p>

***



<!-- DATA PROCESSING -->
# Data Processing

***



<!-- DOCUMENTATION -->
# Documentation

***
<!-- TODO: Add Link-->
Please refer to our [Code Documentation]().



<!-- KNOWN ISSUES -->
# Known Issues

1. Issue 1
2. Issue 3

***



<!-- CONTACT -->
# Contact

##### Project Supervisor
Tim Puhlfürß - [<tim.puhlfuerss@uni-hamburg.de>](mailto:tim.puhlfuerss@uni-hamburg.de)

##### Development Team
- Corvin Biebach - [corvin.biebach@studium.uni-hamburg.de](mailto:corvin.biebach@studium.uni-hamburg.de)
- Maximilian Brosius - [mail@maxbrosius.de](mailto:mail@maxbrosius.de)
- Fynn Menk - [fynn.menk@gmail.com](mailto:fynn.menk@gmail.com)
- Anni Reinert - [anni.reinert@rb-reinert.de](mailto:anni@rb-reinert.de)
- Noah Scheld - [nickels12er@gmail.com](mailto:nickels12er@gmail.com)
- Arne Struck - [arne.struck@studium.uni-hamburg.de](mailto:arne.struck@studium.uni-hamburg.de)
- Mudassar Zahid - [mudassar.zahid@studium.uni-hamburg.de](mailto:mudassar.zahid@studium.uni-hamburg.de) 


Project Link: [UHH Informatics GitLab EE ](https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202122/uke)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
# Acknowledgments
Special Thanks for the friendly help for the Requirements Elicitation and medical questions to:
* [Dr. Mahler](mailto:an.mahler@uke.de) - Emergency Doctor @ UKE Hamburg
* [Dr. Reip](mailto:w.reip@uke.de) - Emergency Doctor @ UKE Hamburg
* [Dr. Sasu](mailto:p.sasu@uke.de) - Emergency Doctor @ UKE Hamburg

And also for providing simulation / real patient data and helping with DataGeneration for the Showcase.
* [Christian Neuhaus](mailto:C.Neuhaus@weinmann-emt.de) - WEINMANN Emergency

<p align="right">(<a href="#top">back to top</a>)</p>
</div>



<!-- MARKDOWN LINKS & IMAGES -->
[issues-shield]: https://img.shields.io/badge/Issues-X%20Closed-orange?style=for-the-badge
[issues-url]: https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202122/uke/-/issues

[commit-shield]:https://img.shields.io/badge/Commits-Number-success?style=for-the-badge
[commit-url]:https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202122/uke/-/commits/main

[team-shield]:https://img.shields.io/badge/Contact-Team-blueviolet?style=for-the-badge
[team-url]:#contact

[website-shield]:https://img.shields.io/badge/Website-VentCore-informational?style=for-the-badge
[website-url]:./README.md

[product-screenshot]: ./ReadMeFiles/ScreenshotMonitoring.png
[StartScreen]:./ReadMeFiles/presets.png
[AlarmLimit]: ./ReadMeFiles/alarmlimit.png
[DefiScreen]:./ReadMeFiles/defibrillation.png
[Add]:./ReadMeFiles/addin.png
[NIBD]:./ReadMeFiles/nibd.png
[Scenario]:./ReadMeFiles/scenario.png
[RedAlarm]:./ReadMeFiles/redalarm.png
[YellowAlarm]:./ReadMeFiles/yellowalarm.png
[Table Audio Priorities]:./ReadMeFiles/table-audio-priority.png
