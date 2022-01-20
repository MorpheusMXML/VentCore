import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';
import 'package:uke_mlab/utilities/enums/alarm_status.dart';

class GraphList {
  RxBool addGraph = false.obs;

  RxList<sensorEnumGraph> list = <sensorEnumGraph>[].obs;

  RxList<sensorEnumAbsolute> activeGraphAbsolutes = <sensorEnumAbsolute>[].obs;

  void graphListAdd(sensorEnumGraph graphKey) {
    list.add(graphKey);
    evaluateActiveGraphAbsolutes();
  }

  void graphListRemove(sensorEnumGraph graphKey) {
    list.remove(graphKey);
    evaluateActiveGraphAbsolutes();
  }

  void graphListSet(List<sensorEnumGraph> newList) {
    list.value = newList;
    evaluateActiveGraphAbsolutes();
  }

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
