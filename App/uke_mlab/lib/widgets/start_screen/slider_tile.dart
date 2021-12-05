import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';

class SliderTile extends StatelessWidget {
  final String name;
  final RxDouble value;

  const SliderTile({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startScreenController = Get.find<StartScreenController>();
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      color: const Color(0xff322f37),
      height: 80 / MediaQuery.of(context).devicePixelRatio,
      child: Row(
        children: [
          //Text
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xffeeeeee),
                ),
              ),
            ),
          ),
          //Slider
          Flexible(
            flex: 8,
            child: Obx(
              () => Slider(
                  min: 0.0,
                  max: 250.0,
                  divisions: 15,
                  value: value.value,
                  label: value.value.round().toString(),
                  onChanged: (newValue) {
                    startScreenController.setValue(newValue, name);
                  }),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(3))),
            alignment: Alignment.center,
            height: 40 / MediaQuery.of(context).devicePixelRatio,
            width: 90 / MediaQuery.of(context).devicePixelRatio,
            child: Obx(
              () => Text(value.value.round().toString()),
            ),
          ),
        ],
      ),
    );
  }
}
