import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/screen_element_models/general_alarms.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/sound_controller.dart';
import 'package:uke_mlab/utilities/constants/statusbar_constants.dart';
import 'package:uke_mlab/widgets/appbar/alarm_field_tile.dart';
import 'package:uke_mlab/utilities/enums/patient_type.dart';
import 'alarm_counter_tile.dart';

class StatusBar extends StatelessWidget {
  /// constructs the status bar for usage over the whole project
  const StatusBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    final SoundController _soundController = Get.find<SoundController>();
    final GeneralAlarms generalAlarms = systemState.generalAlarms;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: StatusBarConstants.flexBarAlarmArea,
          fit: FlexFit.loose,
          child: Row(
            children: [
              //DropDown Menu (AlarmExpansionTile)
              Flexible(
                flex: StatusBarConstants.flexBarAlarmFieldTile,
                child: Obx(() => generalAlarms.alarmList.isEmpty ? Container() : AlarmFieldTile(data: generalAlarms.alarmList[0])),
              ),
              const SizedBox(
                width: StatusBarConstants.horizontalMargin * 2,
              ),
              //Info about Alarm amount (AlarmCounterTile)
              Flexible(
                flex: StatusBarConstants.flexBarAlarmCounterTile,
                child: AlarmCounterTile(),
              ),
            ],
          ),
        ),
        // PatientType display
        Flexible(
          flex: StatusBarConstants.flexBarPatientTypeArea,
          child: Text(
            systemState.patientType.displayString,
            style: TextStyle(
              color: Theme.of(context).dividerColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        // O2 bottly display
        Flexible(
          flex: StatusBarConstants.flexBarO2BottleArea,
          child: Center(child: SvgPicture.asset('assets/icons/OxygenBottle.svg', height: 20)),
        ),
        Flexible(
            flex: StatusBarConstants.flexMuteECGButtonArea,
            child: Obx(
              () => IconButton(
                  onPressed: () => {
                        if (_soundController.ecgSoundActive.value) {_soundController.stop()} else {_soundController.startSaturationHFSound()}
                      },
                  icon: Icon(
                    _soundController.ecgSoundActive.value ? Icons.volume_mute : Icons.volume_off,
                    size: 20,
                  )),
            ))
      ],
    );
  }
}
