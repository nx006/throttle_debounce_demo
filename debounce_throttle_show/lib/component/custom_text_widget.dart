import 'package:debounce_throttle_show/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofucus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofucus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: inputBorderColor, width: 1.0),
    );

    return TextFormField(
      cursorColor: primaryColor,
      obscureText: obscureText,
      autofocus: autofucus,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: bodyTextColor,
          fontSize: 14.0,
        ),
        fillColor: inputBackgroundColor,
        filled: true,
        // 모든 Input 세팅의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(color: primaryColor),
        ),
      ),
    );
  }
}
