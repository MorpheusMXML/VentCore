import 'package:flutter/material.dart';

class IPPVButton extends StatelessWidget {
  const IPPVButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF25232A),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          primary: const Color(0xFF5AC8FA),
        ),
        child: const Text('IPPV', style: TextStyle(fontSize: 25)),
        onPressed: () {},
      ),
    );
  }
}
