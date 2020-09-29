import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/widgets/file_display.dart';

class CommentContent extends StatelessWidget {
  final CommentModel comment;

  CommentContent({this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sm),
        SelectableText(
          comment.content,
          style: TextStyle(
            color: Color(0xDE000000),
            fontWeight: FontWeight.w500,
          ),
        ),
        FileDisplay(comment.files),
      ],
    );
  }
}
