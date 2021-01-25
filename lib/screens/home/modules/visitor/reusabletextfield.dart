import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String labelText;
  final dynamic maxlines;
  final TextInputType keyboardType;
  final String initialValue;
  final Function onTap;
  final Icon prefixIcon;
  final int maxLength;
  final Function onChanged;

  ReusableTextField({
    @required this.labelText,
    this.maxlines,
    this.keyboardType,
    this.onTap,
    this.initialValue,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxlines,
      keyboardType: keyboardType,
      initialValue: initialValue,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
    );
  }
}
