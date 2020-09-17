import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/file_display.dart';

class PostContent extends StatelessWidget {
  final PostModel post;

  PostContent({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sm),
        if (!isEmpty(post.content)) SelectableText(post.content),
        FileDisplay(post.files),
        Divider(),
      ],
    );
  }
}
