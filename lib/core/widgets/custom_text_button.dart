import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle style;
  final String text;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.style,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: style,
        ));
  }
}
