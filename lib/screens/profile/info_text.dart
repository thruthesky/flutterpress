import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoText extends StatelessWidget {
  final String str;
  final String label;
  final double fontSize;
  final double labelSize;
  final FontWeight fontWeight;
  final FontWeight labelFontWeight;

  final double iconSize;

  final double iconRightSpacing;
  final bool centered;
  final EdgeInsets padding;
  final Function onTapped;

  InfoText(
    this.str, {
    this.label = '',
    this.labelSize = sm,
    this.fontSize = md,
    this.fontWeight = FontWeight.w500,
    this.labelFontWeight = FontWeight.w300,
    this.iconSize = sm,
    this.padding = const EdgeInsets.all(sm),
    this.iconRightSpacing = md,
    this.centered = false,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      alignment: centered ? Alignment.center : Alignment.centerLeft,
      children: [
        Text(
          str,
          style: TextStyle(
            color: Colors.black54,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        Positioned(
          right: iconRightSpacing,
          child: Icon(
            FontAwesomeIcons.edit,
            size: iconSize,
            color: Colors.black54,
          ),
        )
      ],
    );

    if (label.isNotEmpty)
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              fontWeight: labelFontWeight,
            ),
          ),
          SizedBox(height: 2),
          SizedBox(width: double.infinity, child: child)
        ],
      );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: child,
      onTap: () {
        print('infoText::tapped');
        if (onTapped != null) onTapped();
      },
    );
  }
}
