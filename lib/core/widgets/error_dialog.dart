import 'package:between_automation/core/consts/text_consts.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String reason;
  const ErrorDialog({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        reason,
        style: TextConsts.instance.regularBlack25,
      ),
    );
  }
}
