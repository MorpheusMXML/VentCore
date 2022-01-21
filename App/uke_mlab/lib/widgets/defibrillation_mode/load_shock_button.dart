import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/providers/sound_controller.dart';

class LoadShockButton extends StatefulWidget {
  const LoadShockButton({Key? key}) : super(key: key);

  @override
  _LoadShockButtonState createState() => _LoadShockButtonState();
}

class _LoadShockButtonState extends State<LoadShockButton> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 6,
      ),
    );
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  DefibrillationController defibrillationController = Get.find<DefibrillationController>();
  SoundController soundController = Get.find<SoundController>();
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (BuildContext _, Widget? __) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: _colorTween.value,
              onPrimary: _colorTween.value,
              side: const BorderSide(
                color: Colors.green,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: _colorTween.value,
                  child: (_animationController.isCompleted && defibrillationController.isReadyToShock == true)
                      ? SvgPicture.asset('assets/icons/Shock.svg')
                      : SvgPicture.asset('assets/icons/Battery.svg'),
                  padding: const EdgeInsets.all(8),
                ),
                const Text('Load'),
              ],
            ),
            onPressed: () {
              setState(
                () {
                  if (!defibrillationController.isReadyToShock) {
                    soundController.playDefiLoadSound();
                    _animationController.forward();
                    defibrillationController.isReadyToShock = true;
                  }
                },
              );
            },
            onLongPress: () {
              setState(() {
                if (defibrillationController.isReadyToShock) {
                  soundController.stop();
                  _animationController.reset();
                  defibrillationController.startLastWatch();
                  defibrillationController.numberOfShocks++;
                  defibrillationController.isReadyToShock = false;
                }
              });
            },
          );
        },
        child: const Icon(Icons.aspect_ratio),
      ),
    );
  }
}
