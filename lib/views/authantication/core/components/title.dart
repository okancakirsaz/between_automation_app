import 'package:flutter/material.dart';

import '../../../../core/consts/text_consts.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  const CustomTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextConsts.instance.regularWhite25Bold,
    );
  }
}
