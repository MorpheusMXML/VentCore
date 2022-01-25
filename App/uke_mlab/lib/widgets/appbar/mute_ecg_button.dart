import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

class MuteEcgButton extends StatelessWidget {
  final SoundController _soundController = Get.find<SoundController>();

  MuteEcgButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: () => {
          if (_soundController.ecgSoundActive.value)
            {_soundController.stop()}
          else
            {_soundController.startSaturationHFSound()}
        },
        icon: Icon(
          _soundController.ecgSoundActive.value ? Icons.volume_mute : Icons.volume_off,
          size: 20,
        ),
      ),
    );
  }
}
