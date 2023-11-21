import 'package:flutter/material.dart';
import 'package:between_automation/core/consts/text_consts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Between",
      textAlign: TextAlign.left,
      style: TextConsts.instance.regularWhite25Bold,
    );
  }
}
