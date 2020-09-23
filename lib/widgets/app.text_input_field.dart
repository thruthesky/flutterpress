import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';

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

  final int minLines;
  final int maxLines;

  final bool withBorder;

  final bool enabled;

  final EdgeInsets contentPadding;

  final double contentSize;

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
    this.minLines = 1,
    this.maxLines = 1,
    this.withBorder = false,
    this.enabled = true,
    this.contentPadding = const EdgeInsets.all(0),
    this.contentSize = md,
  }) : super(key: key);

  @override
  _AppTextInputFieldState createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      autovalidate: validate,
      style: TextStyle(fontSize: widget.contentSize),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.sufficIcon,
        icon: widget.icon,
        focusedBorder: widget.withBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue),
              )
            : null,
        enabledBorder: widget.withBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              )
            : null,
      ),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged(value);
        }
        if (widget.autoValidate) {
          validate = true;
          if (mounted) setState(() {});
        }
      },
    );
  }
}
