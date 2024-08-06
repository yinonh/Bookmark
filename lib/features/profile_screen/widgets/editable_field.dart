import 'package:flutter/material.dart';
import 'package:trivia/utility/app_constant.dart';
import 'package:trivia/utility/color_utility.dart';

class EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const EditableField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppConstant.primaryColor.toColor(),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppConstant.highlightColor.toColor(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppConstant.highlightColor.toColor(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppConstant.highlightColor.toColor(),
          ),
        ),
      ),
    );
  }
}
