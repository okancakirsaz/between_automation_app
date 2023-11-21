import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  final PreferredSizeWidget? tabs;
  final Widget title;

  CustomAppBar({required this.title, this.tabs});
  PreferredSizeWidget build() {
    return AppBar(
      backgroundColor: ColorConsts.instance.primary,
      bottom: tabs,
      title: title,
    );
  }
}
