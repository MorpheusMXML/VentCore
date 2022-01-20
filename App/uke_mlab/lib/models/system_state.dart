import 'package:get/get.dart';

import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/screen_element_models/absolute_alarm_field_model.dart';
import 'package:uke_mlab/models/screen_element_models/graph_list.dart';
import 'package:uke_mlab/models/screen_element_models/ippv_model.dart';
import 'package:uke_mlab/models/screen_element_models/theme_model.dart';

import 'package:uke_mlab/utilities/enums/alarm_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';

import 'package:uke_mlab/utilities/app_theme.dart';

import 'package:uke_mlab/scenarios/abstract_scenario.dart';

import 'package:uke_mlab/screens/main_screen.dart';

class SystemState extends GetxController {
  /// Superclass holding references to various models for screen elements
  /// as well as holding the top level information of current status of the system

  /// contains global information whether an [AbstractScenario] is active
  bool scenarioStarted = false;

  /// contains information which screen is currently active using an element of [screenStatusEnum]
  screenStatusEnum screenStatus = screenStatusEnum.patientSettingScreen;

  /// contains information which patient Type is currently active using an element of [patientTypeEnum]
  patientTypeEnum patientType = patientTypeEnum.none;

  /// contains information which of the three monitoring, ventilation, defibrillation is currently active in [MainScreen]
  /// as a list of true or false values corresponding to the order given above.
  RxList<bool> selectedToggleView = [true, false, false].obs;

  /// contains global information which [sensorEnumAbsolute] currently is in which [alarmStatus],
  /// is of what priority, corresponds to which color and which alarm message will be printed on request
  /// this is done via the RxMap with the following keys:
  /// "priority" for priority
  /// "message" for alarm message
  /// "enum" for current [alarmStatus]
  /// "color" for color
  final RxMap<sensorEnumAbsolute, RxMap<String, dynamic>> alarmState =
      <sensorEnumAbsolute, RxMap<String, dynamic>>{}.obs;

  /// A reference to the current [GeneralAlarms] in use
  final GeneralAlarms generalAlarms = GeneralAlarms();

  /// A reference to the current [GraphList] in use
  final GraphList graphList = GraphList();

  /// A reference to the current [AbsAlarmFieldModel] in use
  final AbsAlarmFieldModel absAlarmFieldModel = AbsAlarmFieldModel();

  /// A reference to the current [IppvModel] in use
  final IppvModel ippvModel = IppvModel();

  /// A reference to the current [ThemeModel] in use
  final ThemeModel themeModel = ThemeModel();

  // SystemState initated with no violations at place and screenStatus as topLevelScreen
  SystemState() {
    for (var sensor in sensorEnumAbsolute.values) {
      alarmState[sensor] = RxMap({
        "priority": 0,
        "message": "none",
        "enum": alarmStatus.none,
        'color': AppTheme.alarmNoneColor,
      });
    }
  }

  /// overwrites [selectedToggleView]s value with [newToggleView] for usage on switch between
  /// monitoring, ventilation and defibrillation representation in [MainScreen]
  void setSelectedToggleView(List<bool> newToggleView) {
    selectedToggleView.value = newToggleView;
    update();
  }
}
