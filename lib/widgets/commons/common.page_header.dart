import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';

class CommonPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;

  final double titleSize;
  final double subtitleSize;
  final double descriptionSize;

  final Color titleColor;
  final Color subtitleColor;
  final Color descriptionColor;

  final FontWeight titleWeight;
  final FontWeight subtitleWeight;
  final FontWeight descriptionWeight;

  final double titleSpacing;
  final double subtitleSpacing;
  final double descriptionSpacing;

  final bool showBackButton;

  CommonPageHeader({
    this.title,
    this.titleSize = 40,
    this.titleColor,
    this.titleWeight = FontWeight.w700,
    this.titleSpacing,
    this.subtitle,
    this.subtitleSize = 12,
    this.subtitleColor,
    this.subtitleWeight = FontWeight.w500,
    this.subtitleSpacing,
    this.description,
    this.descriptionSize = 12,
    this.descriptionColor,
    this.descriptionWeight = FontWeight.normal,
    this.descriptionSpacing,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(
          subtitle,
          style: TextStyle(
              fontSize: subtitleSize,
              color: subtitleColor ?? Colors.black,
              fontWeight: subtitleWeight,
              letterSpacing: subtitleSpacing),
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: titleSize,
              color: titleColor ?? Colors.black,
              fontWeight: titleWeight,
              letterSpacing: titleSpacing),
        ),
        if (!isEmpty(description)) ...[
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
                fontSize: descriptionSize,
                color: descriptionColor ?? Color(0xff5f5f5f),
                fontWeight: descriptionWeight,
                letterSpacing: descriptionSpacing),
          ),
        ]
      ],
    );
  }
}
