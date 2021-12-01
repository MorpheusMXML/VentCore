import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Setting(), Setting(), Setting()],
    );
  }
}