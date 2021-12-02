import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info.dart';

class InfoTile extends StatelessWidget {
  final List<Map<String, Object>> data;
  const InfoTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Info(data: data);
  }
}
