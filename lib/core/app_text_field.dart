import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final int? maxLines;
  const AppTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText is Missing";
        }
        return null;
      },
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
