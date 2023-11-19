import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:flutter/material.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle style;
  final String text;
  final double width;
  final double height;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.style,
      required this.text,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(ColorConsts.instance.lightGray),
              elevation: const MaterialStatePropertyAll(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: RadiusConsts.instance.circularAll5,
                      side: BorderSide(color: ColorConsts.instance.black)))),
          onPressed: onPressed,
          child: Text(
            text,
            style: style,
          )),
    );
  }
}
