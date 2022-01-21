import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

import 'package:uke_mlab/widgets/graph_container/graph_view.dart';
import 'package:uke_mlab/widgets/value_box/value_box_tile.dart';

class GraphList {
  /// contains a list [list] over all currently [GraphView] represented by the corresponding [sensorEnumGraph]

  /// contains information whether a [GraphView] has been added to current screen
  RxBool addGraph = false.obs;

  /// a list containing keys (type [sensorEnumGraph]) of all currently drawn [GraphView]
  RxList<sensorEnumGraph> list = <sensorEnumGraph>[].obs;

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

  /// a list containing keys (type [sensorEnumAbsolute]) of all currently drawn [GraphView]s corresponding [ValueBoxTile]s
  /// which are currently in an active [alarmStatus] (not confirmed and not none)
  RxList<sensorEnumAbsolute> activeGraphAbsolutes = <sensorEnumAbsolute>[].obs;

  /// adds [graphKey] to current [list]
  void graphListAdd(sensorEnumGraph graphKey) {
    list.add(graphKey);
    graphListSort();
    evaluateActiveGraphAbsolutes();
  }

  /// removes [graphKey] from current [list]
  void graphListRemove(sensorEnumGraph graphKey) {
    list.remove(graphKey);
    evaluateActiveGraphAbsolutes();
  }

  /// replaces the current [list] with [newList]
  void graphListSet(List<sensorEnumGraph> newList) {
    list.value = newList;
    graphListSort();
    evaluateActiveGraphAbsolutes();
  }

  /// sorts [list] into a order predefined by active screen
  ///
  /// order is either [monitorList], [ventiList] or [defiList] depending on
  /// currently active [SystemState.selectedToggleView] entry
  void graphListSort() {
    SystemState systemState = Get.find<SystemState>();
    if (systemState.selectedToggleView[0]) {
      //sort after monitorList
      list.sort(
          (a, b) => monitorList.indexOf(a).compareTo(monitorList.indexOf(b)));
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

  /// evaluates the current [activeGraphAbsolutes]
  void evaluateActiveGraphAbsolutes() {
    SystemState systemState = Get.find<SystemState>();
    activeGraphAbsolutes.clear();
    for (var graphSensorKey in list) {
      sensorEnumAbsolute? sensorKey = SensorMapping.sensorMap[graphSensorKey];
      if (sensorKey != null &&
          (systemState.alarmState[sensorKey]!["enum"] != alarmStatus.none &&
              systemState.alarmState[sensorKey]!["enum"] !=
                  alarmStatus.confirmed)) {
        activeGraphAbsolutes.add(sensorKey);
      }
    }
  }
}
