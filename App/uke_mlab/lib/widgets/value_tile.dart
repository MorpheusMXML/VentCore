import 'package:flutter/material.dart';
import 'package:uke_mlab/models/model.dart';
import 'package:uke_mlab/widgets/value_box.dart';

class ValueTile extends StatelessWidget {
  final int textColor;
  final int backgroundColor;
  final String name;
  final DataModel dataModel;

  const ValueTile({
    required this.textColor,
    required this.name,
    required this.backgroundColor,
    required this.dataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(backgroundColor),
      margin: const EdgeInsets.all(12),
      width: double.maxFinite,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Color(textColor),
                  fontSize: 40,
                  // temp fix for long names
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Flexible(
            // cant decrease --> pixel overflow
            flex: 3,
            child: ValueBox(
              backgroundColor: backgroundColor,
              textColor: textColor,
              dataModel: dataModel,
            ),
          ),
        ],
      ),
    );
  }
}
