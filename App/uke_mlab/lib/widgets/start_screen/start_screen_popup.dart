import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/providers/start_screen_controller.dart';
import 'package:uke_mlab/widgets/start_screen/slider_tile.dart';

import 'name_field.dart';

class StartScreenPopup extends StatelessWidget {
  const StartScreenPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartScreenController>(
        init: StartScreenController(),
        builder: (controller) => getWidget(controller, context));
  }

  getWidget(StartScreenController controller, BuildContext context) {
    if (controller.isPopupVisible) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
        color: const Color(0xff25232a),
        height: 320 / MediaQuery.of(context).devicePixelRatio,
        width: 830 / MediaQuery.of(context).devicePixelRatio,
        child: Column(
          //TODO: implement Logic in these 3 Widgets so that we can work with this data in the following
          children: [
            const nameField(),
            SliderTile(name: "Weight", value: controller.weightValue),
            SliderTile(name: "Height", value: controller.heightValue),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 320 / MediaQuery.of(context).devicePixelRatio,
        width: 830 / MediaQuery.of(context).devicePixelRatio,
      );
    }
  }
}
