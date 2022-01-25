import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';
import 'package:uke_mlab/providers/screen_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';
import 'package:uke_mlab/utilities/enums/sensor.dart';

/// This widget displays the button for the smart adjustment feature.
class SmartAdjustButton extends StatelessWidget {
  /// Button for the smart adjustment feature.
  final sensorEnumAbsolute sensorKey;

  /// Creates instance of [SmartAdjustButton].
  const SmartAdjustButton({
    Key? key,
    required this.sensorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    ScreenController screenController = Get.find<ScreenController>();
    SystemState systemState = Get.find<SystemState>();

    return SizedBox(
      height: 25,
      child: Obx(() {
        return systemState.smartAdjustmentMap.map[sensorKey]!.isPressable.value
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  primary: theme.primarySwatch[10],
                  onPrimary: theme.contrastColor,
                ),
                onPressed: () =>
                    screenController.smartAdjustmentButton(sensorKey),
                child: SizedBox(
                  width: 100,
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      systemState.smartAdjustmentMap.map[sensorKey]!
                                  .lowerCounter.value >=
                              3
                          ? const Icon(
                              Icons.arrow_downward_rounded,
                            )
                          : const SizedBox(
                              width: 20,
                            ),
                      const Spacer(),
                      const Text(
                        "s. Adj.",
                      ),
                      const Spacer(),
                      systemState.smartAdjustmentMap.map[sensorKey]!
                                  .upperCounter.value >=
                              3
                          ? const Icon(
                              Icons.arrow_upward_rounded,
                            )
                          : const SizedBox(
                              width: 20,
                            ),
                    ],
                  ),
                ),
              )
            : const SizedBox(
                width: 100,
              );
      }),
    );
  }
}
