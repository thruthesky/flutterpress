import 'package:flutter/material.dart';

class AppTextInputField extends StatefulWidget {
  final TextInputAction inputAction;
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final bool obscureText;
  final bool autoValidate;
  final Widget sufficIcon;

  final Function validator;

  AppTextInputField({
    this.inputAction,
    this.hintText,
    this.controller,
    this.inputType,
    this.focusNode,
    this.onEditingComplete,
    this.obscureText = false,
    this.sufficIcon,
    Key key,
    this.autoValidate = false,
    this.validator(String value),
  }) : super(key: key);

  @override
  _AppTextInputFieldState createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: widget.hintText, suffixIcon: widget.sufficIcon),
      keyboardType: widget.inputType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      onEditingComplete: widget.onEditingComplete ?? () {},
      validator: widget.validator,
      autovalidate: validate,
      onChanged: (value) {
        if (widget.autoValidate) {
          validate = true;
          setState(() {});
        }
      },
    );
  }
}
