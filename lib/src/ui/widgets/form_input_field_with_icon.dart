import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final TextStyle style;
  final InputDecoration decoration;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;

  FormInputFieldWithIcon(
      {@required this.controller,
      @required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      @required this.maxLines,
      @required this.onChanged,
      @required this.onSaved,
      @required this.decoration,
      @required this.style});

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
