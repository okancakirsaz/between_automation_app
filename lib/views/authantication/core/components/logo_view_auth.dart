import 'package:flutter/material.dart';

import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../../../core/widgets/logo.dart';

class LogoViewAuth extends StatelessWidget {
  const LogoViewAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 90,
          width: 280,
          decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularAll100,
              color: ColorConsts.instance.lightGray),
        ),
        Padding(
          padding: PaddingConsts.instance.bottom50,
          child: const Logo(),
        )
      ],
    );
  }
}
