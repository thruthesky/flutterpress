import 'package:flutter/material.dart';

class AppTextInputField extends StatelessWidget {
  final TextInputAction inputAction;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final bool obscureText;

  final Function validator;

  AppTextInputField({
    this.inputAction,
    this.hintText,
    this.controller,
    this.inputType,
    this.focusNode,
    this.onEditingComplete,
    this.obscureText = false,
    Key key,
    this.validator(String value)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: hintText),
      keyboardType: inputType,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      onEditingComplete: onEditingComplete ?? () {},
      validator: validator,
    );
  }
}
