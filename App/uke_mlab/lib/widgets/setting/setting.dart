import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

class Setting extends StatelessWidget {
  final String name;
  final String rate;
  const Setting({
    Key? key,
    required this.name,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monitorController = Get.find<MonitorController>();

    return Container(
      color: const Color(0xFF2A2831),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: SettingText(
              name: name,
              rate: rate,
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () => monitorController.decrementIPPV(name),
              child: const Icon(
                Icons.remove,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                primary: const Color(0xFF5AC8FA),
              ),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () => monitorController.incrementIPPV(name),
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                primary: const Color(0xFF5AC8FA),
              ),
            ),
          )
        ],
      ),
    );
  }
}
