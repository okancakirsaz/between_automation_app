import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'views/authantication/landing_view/view/landing_view.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: ColorConsts.instance.primary,
          iconTheme: const IconThemeData(size: 40)),
      debugShowCheckedModeBanner: false,
      home: const LandingView(),
    );
  }
}
