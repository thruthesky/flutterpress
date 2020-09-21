import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutterpress/defines.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomPageHeader({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.chevronLeft),
              SizedBox(width: lg),
              Text('Back', style: TextStyle(fontSize: md)),
            ],
          ),
          onPressed: () => Get.back(),
        ),
        SizedBox(height: 50),
        Text(subtitle, style: TextStyle(fontSize: lg)),
        Text(
          title,
          style: TextStyle(fontSize: xl, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
