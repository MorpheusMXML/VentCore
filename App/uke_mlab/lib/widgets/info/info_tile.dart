import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/info/info.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Info(),
        Info(),
        Info(),
        Info(),
      ],
    );
  }
}
