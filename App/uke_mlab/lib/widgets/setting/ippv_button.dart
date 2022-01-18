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
      child: Center(
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue[300],
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: DropdownButton(
              isExpanded: true,
              value: systemState.selectedIPPVMode.value,
              onChanged: (newValue) {
                systemState.selectedIPPVMode.value = '$newValue';
              },
              items: <String>['Mode1', 'Mode2', 'Mode3'].map((value) {
                return DropdownMenuItem(
                  child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(value)),
                  value: value,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
