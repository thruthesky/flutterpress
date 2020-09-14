import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class PostButtons extends StatelessWidget {
  final PostModel post;
  final Function onUpdate;
  final Function onDelete;
  final Function onVoted;

  PostButtons({
    this.post,
    this.onUpdate(PostModel post),
    this.onVoted(VoteModel vote),
    this.onDelete,
  });

  vote(String choice) async {
    try {
      var vote = await AppService.wc.postVote({
        'choice': choice,
        'ID': post.id,
      });
      onVoted(vote);
    } catch (e) {
      AppService.error(e);
    }
  }

  onUpdateTap() async {
    var res = await Get.toNamed(
      Routes.postEdit,
      arguments: {'post': post},
    );
    if (!isEmpty(res)) {
      onUpdate(res);
    }
  }

  onDeleteTap() {
    AppService.confirmDialog('delete'.tr, Text('confirmPostDelete'.tr),
        onConfirm: () async {
      try {
        await AppService.wc.postDelete({'ID': post.id});
        onDelete();
      } catch (e) {
        AppService.error('$e'.tr);
      }
    });
  }

  Widget buildButton({String label, Function onTap}) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: sm),
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
    bool mine = AppService.isMine(post);

    var likeText = post.like != '0' ? 'like'.tr + '(${post.like})' : 'like'.tr;
    var dislikeText =
        post.dislike != '0' ? 'dislike'.tr + '(${post.dislike})' : 'dislike'.tr;

    var buttons = [
      {'label': likeText, 'onTap': mine ? null : () => vote('like')},
      {'label': dislikeText, 'onTap': mine ? null : () => vote('dislike')},
    ];

    if (AppService.isMine(post)) {
      buttons.addAll([
        {'label': 'update'.tr, 'onTap': onUpdateTap()},
        {'label': 'delete'.tr, 'onTap': onDeleteTap()}
      ]);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        for (Map<String, dynamic> button in buttons)
          buildButton(label: button['label'], onTap: button['onTap'])
      ]),
    );
  }
}
