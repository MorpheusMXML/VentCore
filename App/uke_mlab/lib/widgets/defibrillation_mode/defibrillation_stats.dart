import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/defibrillation_controller.dart';
import 'package:uke_mlab/utilities/app_theme.dart';

/// Renders the stats for defibrillation: Time since last shock, numer of shocks, overall timer.
/// The timer is only started when entering the toggle screen this widget is on.
///
/// The [DefibrillationController] handles all actions relating to the stats.

/// {@category DefibrillationMode}
class DefibrillationStats extends StatelessWidget {
  /// Widget for displaying defibrillation stats.

  /// Creates instance of [DefibrillationStats].
  const DefibrillationStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DefibrillationController defibrillationController =
        Get.find<DefibrillationController>();
    defibrillationController.startTimerWatch();

    return Flexible(
      child: Container(
        color: theme.primarySwatch[40],
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Last Shock',
                  textAlign: TextAlign.center,
                  style: theme.defiStatsHeadlineTextStyle,
                )),
                Expanded(
                    child: Text(
                  '# Shocks',
                  textAlign: TextAlign.center,
                  style: theme.defiStatsHeadlineTextStyle,
                )),
                Expanded(
                    child: Text(
                  'Timer',
                  textAlign: TextAlign.center,
                  style: theme.defiStatsHeadlineTextStyle,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Obx(() => Text(
                        defibrillationController.lastTimerString.value,
                        textAlign: TextAlign.center,
                        style: theme.defiStatsValueTextStyle))),
                Expanded(
                    child: Obx(() => Text(
                        '${defibrillationController.numberOfShocks}',
                        textAlign: TextAlign.center,
                        style: theme.defiStatsValueTextStyle))),
                Expanded(
                    child: Obx(() => Text(
                        defibrillationController.startTimerString.value,
                        textAlign: TextAlign.center,
                        style: theme.defiStatsValueTextStyle))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
