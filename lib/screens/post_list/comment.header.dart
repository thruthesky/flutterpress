import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';

class CommentHeader extends StatelessWidget {
  final CommentModel comment;

  CommentHeader({@required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularAvatar(
          photoURL: comment.authorPhotoUrl,
          height: 45,
          width: 45,
        ),
        SizedBox(width: xs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.author,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: md),
            ),
            if (!comment.deleted) ...[SizedBox(height: xs), Text(comment.date)],
          ],
        ),
      ],
    );
  }
}
