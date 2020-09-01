import 'package:flutter/material.dart';

class AppTextInputField extends StatefulWidget {
  final TextInputAction inputAction;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  final FocusNode focusNode;
  final Function onEditingComplete;
  final bool obscureText;
  final bool autoValidate;
  final Widget sufficIcon;
  final Widget icon;

  final Function validator;
  final Function onChanged;

  AppTextInputField({
    this.inputAction,
    this.hintText,
    this.labelText,
    this.controller,
    this.inputType,
    this.focusNode,
    this.onEditingComplete,
    this.obscureText = false,
    this.sufficIcon,
    this.icon,
    Key key,
    this.autoValidate = false,
    this.validator(String value),
    this.onChanged(String value),
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
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.sufficIcon,
        icon: widget.icon,
      ),
      keyboardType: widget.inputType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      autovalidate: validate,
      onChanged: (value) {
        widget.onChanged(value);
        if (widget.autoValidate) {
          validate = true;
          if (mounted) setState(() {});
        }
      },
    );
  }
}
