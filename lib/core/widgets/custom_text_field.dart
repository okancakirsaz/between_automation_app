import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final TextStyle style;
  final TextInputType? inputType;
  final String hint;
  const CustomTextField(
      {super.key,
      this.padding,
      required this.controller,
      required this.style,
      this.inputType,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        keyboardType: inputType,
        inputFormatters: inputType == TextInputType.phone ||
                inputType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        cursorColor: Colors.black,
        style: style,
        decoration: InputDecoration(
          filled: true,
          focusColor: ColorConsts.instance.lightGray,
          fillColor: ColorConsts.instance.lightGray,
          alignLabelWithHint: true,
          labelText: hint,
          labelStyle: style,
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConsts.instance.primaryDark)),
        ),
        controller: controller,
      ),
    );
  }
}
