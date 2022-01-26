import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uke_mlab/models/system_state.dart';

/// This widget renders a stylized [ElevatedButton] to add graphs. 
/// The plus icon indicates the adding functionality.
/// After clicking the button, the [GraphAdderPopup] is rendered.
class GraphAdder extends StatelessWidget {
  /// Creates a button that should add graphs.

  /// Creates instance of [GraphAdder]
  const GraphAdder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SystemState systemState = Get.find<SystemState>();

    return ElevatedButton(
      onPressed: () => systemState.graphList.addGraph.toggle(),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.add, size: 40),
    );
  }
}
