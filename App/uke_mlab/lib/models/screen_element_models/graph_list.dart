import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/screen_status.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

import 'package:uke_mlab/widgets/toggle/graph_view.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

/// Contains a list [list] over all currently [GraphView] represented by the corresponding [sensorEnumGraph].
///
/// {@category ScreenElementModels}
class GraphList {
  /// Contains information whether a [GraphView] has been added to current screen.
  RxBool addGraph = false.obs;

  /// A list containing keys (type [sensorEnumGraph]) of all currently drawn [GraphView].
  RxList<sensorEnumGraph> list = <sensorEnumGraph>[].obs;

  /// List that determines the order of graphs displayed in monitor screen.
  List<sensorEnumGraph> monitorList = [
    sensorEnumGraph.ecgCh2,
    sensorEnumGraph.ecgCh1, // ecgs together?
    sensorEnumGraph.pleth,
    sensorEnumGraph.co2,
    sensorEnumGraph.nibd,
    sensorEnumGraph.cpr,
    sensorEnumGraph.paw,
    sensorEnumGraph.flow,
  ];

  /// List that determines the order of graphs displayed in ventilation screen.
  List<sensorEnumGraph> ventiList = [
    sensorEnumGraph.pleth,
    sensorEnumGraph.co2,
    sensorEnumGraph.paw,
    sensorEnumGraph.flow,
    sensorEnumGraph.ecgCh2,
    sensorEnumGraph.ecgCh1,
    sensorEnumGraph.nibd,
    sensorEnumGraph.cpr,
  ];

  /// List that determines the order of graphs displayed in defibrillation screen.
  List<sensorEnumGraph> defiList = [
    sensorEnumGraph.ecgCh2,
    sensorEnumGraph.ecgCh1,
    sensorEnumGraph.co2,
    sensorEnumGraph.cpr,
    sensorEnumGraph.pleth,
    sensorEnumGraph.nibd,
    sensorEnumGraph.paw,
    sensorEnumGraph.flow,
  ];

  /// Represents the standard active graphs for each [screenStatusEnum] that is not [screenStatusEnum.patientSettingScreen] (which obviously does not display graphs).
  Map<screenStatusEnum, List<sensorEnumGraph>> standardGraphs = {
    screenStatusEnum.monitorScreen: [],
    screenStatusEnum.ventilationScreen: [],
    screenStatusEnum.defibrillationScreen: [],
  };

  /// A list containing keys (type [sensorEnumAbsolute]) of all currently drawn [GraphView]s corresponding [ValueBoxTile]s which are currently in an active [alarmStatus] (not confirmed and not none).
  RxList<sensorEnumAbsolute> activeGraphAbsolutes = <sensorEnumAbsolute>[].obs;

  /// Adds [graphKey] to current [list].
  void graphListAdd(sensorEnumGraph graphKey) {
    list.add(graphKey);
    graphListSort();
    evaluateActiveGraphAbsolutes();
  }

  /// Removes [graphKey] from current [list].
  void graphListRemove(sensorEnumGraph graphKey) {
    list.remove(graphKey);
    evaluateActiveGraphAbsolutes();
  }

  /// Replaces the current [list] with [newList].
  void graphListSet(List<sensorEnumGraph> newList) {
    list.value = List.from(newList);
    graphListSort();
    evaluateActiveGraphAbsolutes();
  }

  /// Sorts [list] into a order predefined by active screen.
  ///
  /// The order is either [monitorList], [ventiList] or [defiList] depending on
  /// currently active [SystemState.selectedToggleView] entry
  void graphListSort() {
    SystemState systemState = Get.find<SystemState>();
    if (systemState.selectedToggleView[0]) {
      //sort after monitorList
      list.sort((a, b) => monitorList.indexOf(a).compareTo(monitorList.indexOf(b)));
    } else if (systemState.selectedToggleView[1]) {
      //sort after ventList
      list.sort((a, b) => ventiList.indexOf(a).compareTo(ventiList.indexOf(b)));
    } else if (systemState.selectedToggleView[2]) {
      //sort after defiList
      list.sort((a, b) => defiList.indexOf(a).compareTo(defiList.indexOf(b)));
    } else {
      throw Exception("Trying to sort graphList, no Toggle view was selected");
    }
  }

  /// Evaluates the current [activeGraphAbsolutes].
  void evaluateActiveGraphAbsolutes() {
    SystemState systemState = Get.find<SystemState>();
    activeGraphAbsolutes.clear();
    for (var graphSensorKey in list) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[graphSensorKey];
      if (sensorKey != null &&
          (systemState.alarmState[sensorKey]!["status"] != alarmStatus.none &&
              systemState.alarmState[sensorKey]!["status"] != alarmStatus.confirmed)) {
        activeGraphAbsolutes.add(sensorKey);
      }
    }
  }

  /// Sets the [standardGraphs] for respective scenario.
  void setStandardGraphs(Map<screenStatusEnum, List<sensorEnumGraph>> newGraphs) {
    standardGraphs.clear(); // does this also clear subelements? is this garbage collected?
    standardGraphs = Map.from(newGraphs);
  }

  /// Resets [list] to respective [standardGraphs].
  void resetListToStandardGraphs() {
    SystemState systemState = Get.find<SystemState>();
    if (systemState.selectedToggleView[0]) {
      graphListSet(standardGraphs[screenStatusEnum.monitorScreen] as List<sensorEnumGraph>);
    } else if (systemState.selectedToggleView[1]) {
      graphListSet(standardGraphs[screenStatusEnum.ventilationScreen] as List<sensorEnumGraph>);
    } else if (systemState.selectedToggleView[2]) {
      graphListSet(standardGraphs[screenStatusEnum.defibrillationScreen] as List<sensorEnumGraph>);
    } else {
      throw Exception("Trying to reset graphList, no Toggle view was selected");
    }
  }
}
