import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';

class NoComments extends StatelessWidget {
  final textColor = Color(0xDE000000);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'No comments, yet.',
        style: TextStyle(
            fontSize: 20, color: textColor, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: sm),
      Text(
        'Be the first to add a comment on this post.',
        style: TextStyle(
            fontSize: 14, color: textColor, fontWeight: FontWeight.w400),
      ),
      SizedBox(height: xs),
      FlatButton(
        child: Text(
          'Create a comment',
          style: TextStyle(color: Color(0xff1684D0), fontSize: 12),
        ),
        onPressed: () {},
      ),
    ]);
  }
}
