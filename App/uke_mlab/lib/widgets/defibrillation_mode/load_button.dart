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

    return Obx(
      () => defibrillationController.loaded.value
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).shadowColor,
                onPrimary: Colors.green,
                side: const BorderSide(
                  color: Colors.green,
                ),
              ),
              onPressed: () => defibrillationController.toggleLoaded(),
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: SvgPicture.asset('assets/icons/Battery.svg'),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Text('Load'),
                  ),
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.black,
                  side: const BorderSide(color: Colors.white)),
              onPressed: () => defibrillationController.toggleLoaded(),
              child: Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: SvgPicture.asset('assets/icons/Shock.svg'),
                      margin: const EdgeInsets.all(8),
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Text('Shock'),
                  ),
                ],
              ),
            ),
    );
  }
}
