import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/sound_controller.dart';
import 'package:uke_mlab/widgets/appbar/statusbar.dart';

/// Renders a [IconButton] to display a little helper button in the [StatusBar].
/// This button mutes and restarts the ecg sound from the [SoundController] with [_soundController.startSaturationHFSound()]
/// Holds a reference to the [SoundController] in [_soundController] got with [GetX]
///
/// {@category AppBar}
class MuteEcgButton extends StatelessWidget {
  final SoundController _soundController = Get.find<SoundController>();

  MuteEcgButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: () =>
            _soundController.ecgSoundActive.value ? _soundController.stop() : _soundController.startSaturationHFSound(),
        icon: Icon(
          _soundController.ecgSoundActive.value ? Icons.volume_mute : Icons.volume_off,
          size: 20,
        ),
      ),
    );
  }
}
