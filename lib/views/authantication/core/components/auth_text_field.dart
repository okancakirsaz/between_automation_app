import 'package:flutter/material.dart';

import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/text_consts.dart';
import '../../../../core/widgets/custom_text_field.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  const AuthTextField({super.key, required this.controller, this.inputType});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hint: "",
        padding: PaddingConsts.instance.horizontal30,
        controller: controller,
        inputType: inputType,
        style: TextConsts.instance.regularBlack18);
  }
}
