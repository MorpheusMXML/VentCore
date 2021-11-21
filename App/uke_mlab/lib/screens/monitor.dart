import 'package:flutter/material.dart';

import 'package:uke_mlab/widgets/example_flexible.dart';

class Monitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              ExampleFlexible(),
              ExampleFlexible(),
              ExampleFlexible(),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(height: 100, color: Colors.amber),
              ),
              Flexible(
                flex: 1,
                child: Container(height: 100, color: Colors.blue),
              ),
              Flexible(
                flex: 2,
                child: Container(height: 100, color: Colors.purple),
              ),
            ],
          ),
        )
      ],
    );
  }
}
