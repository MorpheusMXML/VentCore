import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

class Setting extends StatelessWidget {
  final MonitorController controller;
  final String name;
  final String rate;
  const Setting(
      {Key? key,
      required this.controller,
      required this.name,
      required this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.remove),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: SettingText(
            controller: controller,
            name: name,
            rate: rate,
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              // TODO: find fix to only alter one setting
              controller.increment(name);
            },
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
          ),
        ),
      ],
    );
  }
}
