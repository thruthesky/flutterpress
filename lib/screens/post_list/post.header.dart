import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  PostHeader({this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularAvatar(
          photoURL: post.authorPhotoUrl,
          height: 55,
          width: 55,
        ),
        SizedBox(width: xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: md),
              ),
              SizedBox(height: 2),
              Text('${post.authorName}'),
              Text('${post.date}'),
            ],
          ),
        )
      ],
    );
  }
}
