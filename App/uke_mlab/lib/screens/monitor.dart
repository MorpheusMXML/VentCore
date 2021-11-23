import 'package:flutter/material.dart';

import 'package:uke_mlab/widgets/example_flexible.dart';
import 'package:uke_mlab/widgets/value_tile.dart';

class Monitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 4,
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
                child: Row(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: ValueTile(
                        name: "Pulse",
                        textColor: 0xffFF00E4,
                        backgroundColor: 0xff2A2831,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ValueTile(
                        name: "Breath. Freq.",
                        textColor: 0xff0CECDD,
                        backgroundColor: 0xff2A2831,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(color: Colors.amber),
              ),
              Flexible(
                flex: 1,
                child: Container(color: Colors.purple),
              ),
            ],
          ),
        )
      ],
    );
  }
}
