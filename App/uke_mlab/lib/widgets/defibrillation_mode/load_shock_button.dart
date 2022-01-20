import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

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
        milliseconds: 500,
      ),
    )..addListener(() {
        setState(() {});
      });
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  DefibrillationController defibrillationController = Get.find<DefibrillationController>();
  late AnimationController _animationController;
  late Animation _colorTween;
  @override
  Widget build(BuildContext context) {
    ButtonStyle loadButtonStyle = ElevatedButton.styleFrom(
      primary: Theme.of(context).shadowColor,
      onPrimary: Colors.green,
      side: const BorderSide(
        color: Colors.green,
      ),
    );

    ButtonStyle shockButtonStyle = ElevatedButton.styleFrom(
      primary: Colors.red,
      onPrimary: Colors.black,
      side: const BorderSide(color: Colors.white),
    );
    return Container(
        margin: const EdgeInsets.all(8),
        child: TweenAnimationBuilder<Color>(
          tween: Tween(begin: Colors.transparent, end: Colors.red),
          duration: const Duration(seconds: 3),
          builder: (BuildContext context, Color color, Widget? child) {
            return ElevatedButton(
              style: loadButtonStyle,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: _colorTween.value,
                    child: SvgPicture.asset('assets/icons/Battery.svg'),
                    padding: const EdgeInsets.all(8),
                  ),
                  const Text('Load'),
                ],
              ),
              onPressed: () {
                setState(() {});
              },
            );
          },
          child: const Icon(Icons.aspect_ratio),
        ));

/* 
                  defibrillationController.startLastWatch();
                  defibrillationController.numberOfShocks++;
                  defibrillationController.animHeight = 0.obs;
                  defibrillationController.defiState = DefibrillationState.readyToLoad;
    */
  }
}

enum DefibrillationState {
  readyToLoad,
  readyToShock,
}
