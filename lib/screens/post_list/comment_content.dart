import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/widgets/file_display.dart';

class CommentContent extends StatelessWidget {
  final CommentModel comment;

  CommentContent({this.comment});

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [
      Text(comment.author, style: TextStyle(fontWeight: FontWeight.w700))
    ];

    if (!comment.deleted) {
      contents.addAll([
        Text(comment.content),
        SizedBox(height: xs),
        FileDisplay(comment.files),
      ]);
    }

    return Container(
      padding: EdgeInsets.all(xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contents,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
    );
  }
}
