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
