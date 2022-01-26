import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

/// Renders a [IconButton] to display a little Helper Button in the Statusbar.
/// This Button Mutes and restarts the ECG Sound from the [SoundController] with [_soundController.startSaturationHFSound()]
/// Holds a reference to the [SoundController] in [_soundController] got with [GetX]
/// {@category Widgets}
/// {@subCategory Appbar}
class MuteEcgButton extends StatelessWidget {
  final SoundController _soundController = Get.find<SoundController>();

  MuteEcgButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: () => _soundController.ecgSoundActive.value
            ? _soundController.stop()
            : _soundController.startSaturationHFSound(),
        icon: Icon(
          _soundController.ecgSoundActive.value
              ? Icons.volume_mute
              : Icons.volume_off,
          size: 20,
        ),
      ),
    );
  }
}
