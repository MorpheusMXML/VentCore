import 'package:flutter/material.dart';

import 'package:uke_mlab/widgets/graph_container.dart';
import 'package:uke_mlab/widgets/value_tile.dart';
import 'package:uke_mlab/widgets/graph_adder.dart';

class Monitor extends StatelessWidget {
  const Monitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: Column(
            children: const [
              GraphContainer(),
              GraphContainer(),
              GraphContainer(),
              GraphAdder(),
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
