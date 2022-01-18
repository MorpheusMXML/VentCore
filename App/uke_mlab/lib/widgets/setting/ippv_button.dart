import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

class IPPVButton extends StatelessWidget {
  const IPPVButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          hint: const DropdownMenuItem(child: Text('IPPV')),
          onChanged: (value) {},
          // TODO: Add items here
          items: const [],
        ),
      ),
    );
  }
}
