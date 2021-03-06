import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:get/get.dart';

class CommentHeader extends StatelessWidget {
  final CommentModel comment;

  CommentHeader({@required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularAvatar(
          photoURL: comment.deleted ? '' : comment.authorPhotoUrl,
          height: 42,
          width: 42,
        ),
        SizedBox(width: xs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.deleted ? 'deleted'.tr : comment.authorName,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: sm),
            ),
            if (!comment.deleted) ...[
              SizedBox(height: xs),
              Text('No. ' + comment.id.toString() + ' - ' + comment.date),
            ],
          ],
        ),
      ],
    );
  }
}
