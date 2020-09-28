import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  final Color lineColor;
  final double spacing;
  final double lineThickness;

  OrDivider({
    this.fontSize,
    this.fontColor,
    this.fontWeight = FontWeight.w300,
    this.lineColor,
    this.spacing = 5,
    this.lineThickness = 1,
  });

  final defaultColor = Color(0xffAFAFAF);

  @override
  Widget build(BuildContext context) {
    Widget line = Expanded(
      child: Divider(
        color: lineColor ?? defaultColor,
        thickness: lineThickness,
      ),
    );

    return Row(
      children: [
        line,
        Container(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: fontColor ?? defaultColor,
            ),
          ),
        ),
        line
      ],
    );
  }
}
