import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.onChanged,
      this.onSaved,
      this.decoration,
      this.style});

  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final TextStyle style;
  final InputDecoration decoration;
  final void Function(String) onChanged;
  final void Function(String) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      decoration: decoration,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}
