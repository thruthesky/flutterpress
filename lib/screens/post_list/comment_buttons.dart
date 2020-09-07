import 'package:flutter/material.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class CommentButtons extends StatelessWidget {
  final CommentModel comment;
  final Function onReplyTap;
  final Function onUpdateTap;
  final Function onDeleteTap;
  final Function onVoted;
  final bool showReplyButton;
  final bool inEdit;

  CommentButtons({
    this.comment,
    this.onReplyTap,
    this.onUpdateTap,
    this.onDeleteTap,
    this.onVoted(VoteModel vote),
    this.showReplyButton,
    this.inEdit = false,
  });

  vote(String choice) async {
    try {
      var vote = await AppService.wc.commentVote({
        'choice': choice,
        'ID': comment.id,
      });
      onVoted(vote);
    } catch (e) {
      AppService.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (showReplyButton)
          RaisedButton(
            child: Text('reply'.tr),
            onPressed: onReplyTap,
          ),
        if (AppService.isMine(comment) && !inEdit)
          RaisedButton(
            child: Text('update'.tr),
            onPressed: onUpdateTap,
          ),
        if (AppService.isMine(comment) && !inEdit)
          RaisedButton(
            child: Text('delete'.tr),
            onPressed: onDeleteTap,
          ),
        if (!AppService.isMine(comment))
          RaisedButton(
            child: Text('like'.tr + comment.like),
            onPressed: () => vote('like'),
          ),
        if (!AppService.isMine(comment))
          RaisedButton(
            child: Text('dislike'.tr + comment.dislike),
            onPressed: () => vote('dislike'),
          ),
      ],
    );
  }
}
