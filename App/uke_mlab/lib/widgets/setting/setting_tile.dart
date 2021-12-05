import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/setting/setting.dart';

class SettingTile extends StatelessWidget {
  final MonitorController controller;
  const SettingTile({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
            child: const Text("IPPV"),
            onPressed: () {},
          ),
        ),
        Setting(controller: controller, name: "Freq.", rate: "/min"),
        Setting(controller: controller, name: "Vt", rate: "ml"),
        Setting(controller: controller, name: "PEEP", rate: "mBar"),
      ],
    );
  }
}
