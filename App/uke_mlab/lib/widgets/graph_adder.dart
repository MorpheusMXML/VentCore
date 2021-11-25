import 'package:flutter/material.dart';

class GraphAdder extends StatefulWidget {
  const GraphAdder({Key? key}) : super(key: key);

  @override
  _GraphAdderState createState() => _GraphAdderState();
}

class _GraphAdderState extends State<GraphAdder> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showGraphs(),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[800],
        fixedSize: const Size(80, 80),
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.add, size: 40),
    );
  }

  showGraphs() {
    setState(() {});
  }
}
