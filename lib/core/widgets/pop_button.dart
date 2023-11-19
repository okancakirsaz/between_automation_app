import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  final TextStyle style;
  const PopButton({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "{ Önceki Sayfaya Dön",
          style: style,
        ),
      ),
    );
  }
}
