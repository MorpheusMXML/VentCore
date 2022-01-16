import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';

class LoadButton extends StatelessWidget {
  const LoadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();

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
      child: Obx(
        () {
          switch (defibrillationController.loaded.value) {
            case 'Loaded':
              return ElevatedButton(
                style: loadButtonStyle,
                onPressed: () => defibrillationController.toggleLoaded('Shock'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset('assets/icons/Battery.svg'),
                      padding: const EdgeInsets.all(8),
                    ),
                    const Text('Load'),
                  ],
                ),
              );
            case 'Loading':
              return ElevatedButton(
                style: loadButtonStyle,
                onPressed: null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset('assets/icons/Battery.svg'),
                      padding: const EdgeInsets.all(8),
                    ),
                    const Text('Loading...'),
                  ],
                ),
              );
            case 'Shock':
              return ElevatedButton(
                style: shockButtonStyle,
                onPressed: () {
                  defibrillationController.startLastWatch();
                  defibrillationController.toggleLoaded('Loaded');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SvgPicture.asset('assets/icons/Shock.svg'),
                      margin: const EdgeInsets.all(8),
                    ),
                    const Text('Shock'),
                  ],
                ),
              );
            default:
              // TODO; Return Error widget here?
              return const Text('Error');
          }
        },
      ),
    );
  }
}
