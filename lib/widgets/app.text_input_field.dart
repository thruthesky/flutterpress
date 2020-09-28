import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';

class AppTextInputField extends StatefulWidget {
  final Key key;

  final Function validator;
  final Function onChanged;
  final Function onEditingComplete;

  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final FocusNode focusNode;

  final bool autoValidate;
  final bool obscureText;
  final bool withBorder;
  final bool enabled;

  final Widget sufficIcon;
  final Widget icon;

  final int minLines;
  final int maxLines;

  final String hintText;
  final String labelText;

  final double contentSize;
  final double labelSize;
  final double hintSize;

  final FontWeight contentWeight;
  final FontWeight labelWeight;
  final FontWeight hintWeight;

  final Color contentColor;
  final Color labelColor;
  final Color hintColor;

  final EdgeInsets contentPadding;

  AppTextInputField({
    this.key,
    this.validator(String value),
    this.onChanged(String value),
    this.onEditingComplete,
    this.controller,
    this.inputAction,
    this.inputType,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.sufficIcon,
    this.icon,
    this.autoValidate = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.withBorder = false,
    this.enabled = true,
    this.contentSize = md,
    this.labelSize = 18,
    this.hintSize = md,
    this.contentWeight = FontWeight.normal,
    this.labelWeight = FontWeight.normal,
    this.hintWeight = FontWeight.normal,
    this.contentColor,
    this.labelColor,
    this.hintColor,
    this.contentPadding = const EdgeInsets.only(right: 0, bottom: 5, left: 0),
  });

  @override
  _AppTextInputFieldState createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    InputBorder focused;
    InputBorder enabled = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    );

    if (widget.withBorder) {
      focused = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.blue),
      );
      enabled = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey),
      );
    }

    return TextFormField(
      key: widget.key,
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
      style: TextStyle(
        color: widget.contentColor ?? Colors.black,
        fontSize: widget.contentSize,
        fontWeight: widget.contentWeight,
      ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.labelColor ?? Color(0xff717171),
          fontSize: widget.labelSize,
          fontWeight: widget.labelWeight,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintColor ?? Color(0xffb7b7b7),
          fontSize: widget.hintSize,
          fontWeight: widget.hintWeight,
        ),
        suffixIcon: widget.sufficIcon,
        icon: widget.icon,
        focusedBorder: focused,
        enabledBorder: enabled,
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
