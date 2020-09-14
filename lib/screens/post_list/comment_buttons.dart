import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
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
    if (!AppService.wc.isUserLoggedIn) {
      AppService.confirmDialog(
        'loginFirst'.tr,
        Text('Login first to vote'),
        textConfirm: 'login'.tr,
        onConfirm: () => Get.toNamed(Routes.login),
        onCancel: () {
          return;
        },
      );
    } else {
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
  }

  Widget buildButton({String label, Function onTap}) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: sm, top: xs),
        child: Text(
          label,
          style: TextStyle(
            fontSize: md,
            color: onTap != null ? Colors.blue[500] : Colors.grey,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool mine = AppService.isMine(comment);

    var likeText =
        comment.like != '0' ? 'like'.tr + '(${comment.like})' : 'like'.tr;
    var dislikeText = comment.dislike != '0'
        ? 'dislike'.tr + '(${comment.dislike})'
        : 'dislike'.tr;

    var buttons = [
      if (AppService.wc.isUserLoggedIn)
        {'label': 'reply'.tr, 'onTap': onReplyTap},
      {'label': likeText, 'onTap': mine ? null : () => vote('like')},
      {'label': dislikeText, 'onTap': mine ? null : () => vote('dislike')},
    ];

    if (AppService.isMine(comment)) {
      buttons.addAll([
        {'label': 'update'.tr, 'onTap': onUpdateTap},
        {'label': 'delete'.tr, 'onTap': onDeleteTap},
      ]);
    }

    return Wrap(children: [
      for (Map<String, dynamic> button in buttons)
        buildButton(label: button['label'], onTap: button['onTap'])
    ]);
  }
}
