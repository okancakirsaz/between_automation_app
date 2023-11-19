import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:between_automation/core/consts/asset_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          width: 100,
          height: 100,
          AssetConsts.instance.logo,
        ),
        Text("Irish Coffe", style: TextConsts.instance.regularBlack25Bold)
      ],
    );
  }
}
