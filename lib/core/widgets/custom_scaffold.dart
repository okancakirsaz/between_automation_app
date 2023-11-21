import 'package:flutter/material.dart';

import '../consts/color_consts/color_consts.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  const CustomScaffold({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: ColorConsts.instance.background,
      body: body,
    );
  }
}
