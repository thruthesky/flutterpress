import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';

class NoPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(md),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No posts, yet.',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: md),
          Text(
            'Won’t you be the first to write?',
            style: TextStyle(
              fontSize: 19,
              color: Color(0xDE000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: md),
          Text(
            'Please...',
            style: TextStyle(
              fontSize: md,
              color: Color(0xDE000000),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
