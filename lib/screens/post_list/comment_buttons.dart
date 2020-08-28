import 'package:flutter/material.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class CommentButtons extends StatelessWidget {
  final CommentModel comment;
  final Function onReplyTap;
  final Function onUpdateTap;
  final Function onDeleteTap;

  CommentButtons({
    this.comment,
    this.onReplyTap,
    this.onUpdateTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RaisedButton(
          child: Text('reply'.tr),
          onPressed: onReplyTap,
        ),
        if (AppService.isMine(comment))
          RaisedButton(
            child: Text('update'.tr),
            onPressed: onUpdateTap,
          ),
        if (AppService.isMine(comment))
          RaisedButton(
            child: Text('delete'.tr),
            onPressed: onDeleteTap,
          ),
      ],
    );
  }
}
