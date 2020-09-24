import 'package:flutter/material.dart';

class CommonFormSubmitButton extends StatelessWidget {
  final Key key;
  final Function onPressed;
  final EdgeInsets padding;
  final String text;
  final double textSize;
  final Color textColor;
  final Color buttonColor;

  CommonFormSubmitButton({
    @required this.text,
    @required this.onPressed,
    this.buttonColor,
    this.textColor = Colors.white,
    this.textSize = 20,
    this.padding,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        padding: padding ?? EdgeInsets.all(14),
        key: key,
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: TextStyle(fontSize: textSize),
        ),
        color: buttonColor ?? Color(0xff0496e1),
        textColor: textColor,
      ),
    );
  }
}
