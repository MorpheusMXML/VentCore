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

  /// a list containing keys (type [sensorEnumAbsolute]) of all currently drawn [GraphView]s corresponding [ValueBoxTile]s
  /// which are currently in an active [alarmStatus] (not confirmed and not none)
  RxList<sensorEnumAbsolute> activeGraphAbsolutes = <sensorEnumAbsolute>[].obs;

  /// adds [graphKey] to current [list]
  void graphListAdd(sensorEnumGraph graphKey) {
    list.add(graphKey);
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
    evaluateActiveGraphAbsolutes();
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
