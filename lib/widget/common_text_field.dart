import '../utils/constants/color_utils.dart';
import '../utils/constants/font_sizes.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validation;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool isProfile;
  final bool isMaxline;

  CommonTextField(
      {required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.validation,
      this.onTap,
      this.prefixIcon,
      this.keyboardType,
      this.suffixIcon,
      this.readOnly = false,
      this.isMaxline = false,
      this.textInputAction = TextInputAction.next,
      this.focusNode,
      this.isProfile = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validation,
        readOnly: readOnly,
        onTap: onTap,
        focusNode: focusNode,
        onChanged: onChanged,
        maxLines: isMaxline ? 5 : 1,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: primaryColor,
        style: TextStyle(
            fontSize: fontSize16,
            color: blackColor,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            labelText: hintText,
            labelStyle: TextStyle(fontSize: fontSize12, color: blackColor),
            fillColor: whiteColor,
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: secondaryGradientColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: secondaryGradientColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: secondaryGradientColor, width: 1)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: redColor, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: secondaryGradientColor, width: 1)),
            contentPadding: EdgeInsetsDirectional.only(
                start: 10, end: 10, top: isProfile ? 5 : 10, bottom: 10)),
      ),
    );
  }
}
