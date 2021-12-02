import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/setting/setting_text.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.remove),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
          ),
        ),
        const Flexible(flex: 2, child: SettingText()),
        Flexible(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              primary: const Color(0xFF5AC8FA),
            ),
          ),
        ),
      ],
    );
  }
}
