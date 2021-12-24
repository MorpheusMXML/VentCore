import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/setting.dart';

class SettingTile extends StatelessWidget {
  final List<Map<String, Object>> data;
  const SettingTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF25232A),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              primary: const Color(0xFF5AC8FA),
            ),
            child: const Text("IPPV", style: TextStyle(fontSize: 25)),
            onPressed: () {},
          ),
        ),
        ...data
            .map((e) => Container(
                  color: const Color(0xFF25232A),
                  padding: const EdgeInsets.all(8),
                  child: Setting(
                    name: e["name"].toString(),
                    rate: e["rate"].toString(),
                  ),
                ))
            .toList()
      ],
    );
  }
}
