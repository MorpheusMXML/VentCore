import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class View extends StatelessWidget {
  final Color containerColor;

  View({required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridRow(
      children: [
        ResponsiveGridCol(
          md: 8,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                color: containerColor,
              ),
            ],
          ),
        ),
        ResponsiveGridCol(
          md: 4,
          child: Container(
            height: 100,
            color: containerColor,
          ),
        ),
      ],
    );
  }
}
