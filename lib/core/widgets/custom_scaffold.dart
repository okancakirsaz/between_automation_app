import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  const CustomScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConsts.instance.background,
      body: body,
    );
  }
}
