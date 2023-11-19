import 'package:flutter/material.dart';
import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:between_automation/core/consts/padding_consts.dart';
import 'package:between_automation/core/consts/radius_consts.dart';
import 'package:between_automation/core/consts/text_consts.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onPressed;
  const CustomCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingConsts.instance.horizontal10,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConsts.instance.lightGray,
          borderRadius: RadiusConsts.instance.circularAll100),
      child: ListTile(
        title: Text(title, style: TextConsts.instance.regularBlack18Bold),
        subtitle: Text(subTitle, style: TextConsts.instance.regularBlack12),
        trailing: TextButton(
            onPressed: onPressed,
            child: Padding(
              padding: PaddingConsts.instance.bottom15,
              child: Icon(
                Icons.delete,
                size: 45,
                color: ColorConsts.instance.red,
              ),
            )),
      ),
    );
  }
}
