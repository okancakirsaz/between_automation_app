import 'package:flutter/material.dart';

class ColorConsts {
  static final ColorConsts instance = ColorConsts();
  final Color lightGray = const Color(0xFFF4F4F4);
  final Color background = const Color(0xFFF4F4F4);
  final Color black = const Color(0xFF000000);
  final Color primary = const Color(0xFFebdc5b);
  final Color primaryDark = const Color.fromARGB(255, 204, 189, 58);
  final Color secondary = const Color(0xFF008C45);
  final Color red = const Color(0xFFE20707);
  final List<BoxShadow> shadow = [
    const BoxShadow(
      offset: Offset(5, 5),
      blurRadius: 5,
      color: Color(0x25000000),
    )
  ];
}
