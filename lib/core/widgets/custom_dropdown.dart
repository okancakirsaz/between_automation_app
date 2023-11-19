import 'package:between_automation/core/consts/color_consts/color_consts.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuEntry> props;
  final String hint;
  final TextEditingController controller;
  const CustomDropdown(
      {super.key,
      required this.props,
      required this.hint,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: (value) {
        controller.text = value;
      },
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorConsts.instance.lightGray,
        border: const OutlineInputBorder(),
        activeIndicatorBorder:
            BorderSide(color: ColorConsts.instance.primaryDark),
      ),
      hintText: hint,
      requestFocusOnTap: false,
      controller: controller,
      dropdownMenuEntries: props,
    );
  }
}
