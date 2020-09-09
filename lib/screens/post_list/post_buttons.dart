import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/keys.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Divider(),

          /// update
          if (AppService.isMine(post))
            RaisedButton(
              key: ValueKey(Keys.postUpdateButton),
              child: Text('update'.tr),
              onPressed: () async {
                var res = await Get.toNamed(
                  Routes.postEdit,
                  arguments: {'post': post},
                );
                if (!isEmpty(res)) {
                  onUpdate(res);
                }
              },
            ),

          /// delete
          if (AppService.isMine(post))
            RaisedButton(
              key: ValueKey(Keys.postDeleteButton),
              child: Text('delete'.tr),
              onPressed: () {
                AppService.confirmDialog(
                    'delete'.tr, Text('confirmPostDelete'.tr),
                    onConfirm: () async {
                  try {
                    await AppService.wc.postDelete({'ID': post.id});
                    onDelete();
                  } catch (e) {
                    AppService.error('$e'.tr);
                  }
                }, onCancel: Get.back);
              },
            ),

          /// Like
          if (!AppService.isMine(post))
            RaisedButton(
              key: ValueKey(Keys.postLikeButton),
              child: Text('like'.tr + post.like),
              onPressed: () => vote('like'),
            ),

          /// dislike
          if (!AppService.isMine(post))
            RaisedButton(
              key: ValueKey(Keys.postDislikeButton),
              child: Text('dislike'.tr + post.dislike),
              onPressed: () => vote('dislike'),
            ),
        ],
      ),
    );
  }
}
