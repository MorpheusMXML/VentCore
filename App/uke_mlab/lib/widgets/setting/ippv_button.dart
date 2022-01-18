import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class IPPVButton extends StatelessWidget {
  const IPPVButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();
    final List<String> items = ['Mode1', 'Mode2', 'Mode3'];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<dynamic>(
              isExpanded: true,
              hint: const Text('IPPV'),
              value: null,
              onChanged: (value) {},
              items: items.map((value) {
                return DropdownMenuItem(
                  onTap: () {},
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
      ),
    );
  }
}
