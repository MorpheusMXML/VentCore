import 'package:flutter/material.dart';
import 'package:uke_mlab/providers/mockup.dart';
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
          margin: const EdgeInsets.only(
              right: 8), //button was to wide on the right side
          color: const Color(0xFF25232A), //TODO: check with styleTheme?
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(
                  15), //expands button size to container size, bad practice!
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
            child: const Text("IPPV"),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: const Color(0xFF25232A),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 8),
                child: Setting(
                  name: data[index]["name"].toString(),
                  rate: data[index]["rate"].toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
