import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/widgets/file_display.dart';

class CommentContent extends StatelessWidget {
  final CommentModel comment;

  CommentContent({this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.author, style: TextStyle(fontWeight: FontWeight.w700)),
          Text(comment.content),
          SizedBox(height: xs),
          FileDisplay(comment.files),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
    );
  }
}
