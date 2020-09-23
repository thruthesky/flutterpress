import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/defines.dart';

class CustomPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final bool showBackButton;

  final double titleSize;
  final double subtitleSize;
  final double descriptionSize;

  CustomPageHeader({
    this.title,
    this.titleSize = xl,
    this.subtitle,
    this.subtitleSize = lg,
    this.description,
    this.descriptionSize = md,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(subtitle, style: TextStyle(fontSize: subtitleSize)),
        Text(
          title,
          style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
        ),
        if (!isEmpty(description))
          Text(description, style: TextStyle(fontSize: descriptionSize)),
      ],
    );
  }
}
