import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class aedButton extends StatelessWidget {
  const aedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 65, 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
                250 / MediaQuery.of(context).devicePixelRatio,
                250 / MediaQuery.of(context).devicePixelRatio),
            primary: const Color(0xff363638),
            onPrimary: Color(0xff34c759),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () {},
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/AED.svg',
                height: 100,
                width: 100,
                color: Color(0xff34c759),
              ),
              Text('AED')
            ],
          )),
    );
  }
}