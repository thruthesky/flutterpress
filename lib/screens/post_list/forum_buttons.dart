import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/commons/common.button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForumButtons extends StatefulWidget {
  final int parentID;

  final bool showReplyButton;

  final bool isComment;
  final bool inEdit;
  final bool mine;

  final int likeCount;
  final int dislikeCount;

  final Function onReplyTap;
  final Function onUpdateTap;
  final Function onDeleteTap;
  final Function onVoted;

  ForumButtons({
    @required this.parentID,
    this.showReplyButton = false,
    this.isComment = false,
    this.inEdit = false,
    this.mine,
    this.likeCount = 0,
    this.dislikeCount = 0,
    this.onReplyTap,
    @required this.onUpdateTap,
    @required this.onDeleteTap,
    @required this.onVoted(VoteModel vote),
  });

  @override
  _ForumButtonsState createState() => _ForumButtonsState();
}

class _ForumButtonsState extends State<ForumButtons> {
  String loading;

  onVoteButtonTapped(String choice) async {
    if (loading != null) return;

    if (widget.mine) {
      AppService.error(
          'You can\'t vote on your own ${widget.isComment ? 'comment' : 'post'}');
      setState(() => loading = null);
      return;
    }

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
    }

    try {
      var vote;
      if (widget.isComment) {
        vote = await AppService.wc.commentVote({
          'choice': choice,
          'ID': widget.parentID,
        });
      } else {
        vote = await AppService.wc.postVote({
          'choice': choice,
          'ID': widget.parentID,
        });
      }
      widget.onVoted(vote);
      setState(() => loading = null);
    } catch (e) {
      AppService.error(e);
      setState(() => loading = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var likeText =
        widget.likeCount > 0 ? 'like'.tr + '(${widget.likeCount})' : 'like'.tr;
    var dislikeText = widget.dislikeCount > 0
        ? 'dislike'.tr + '(${widget.dislikeCount})'
        : 'dislike'.tr;

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(children: [
        if (widget.showReplyButton)
          ForumButton(
            label: 'reply'.tr,
            onTap: widget.onReplyTap,
          ),
        ForumButton(
          label: likeText,
          loading: loading == 'like',
          onTap: () {
            setState(() => loading = 'like');
            onVoteButtonTapped('like');
          },
        ),
        ForumButton(
          label: dislikeText,
          loading: loading == 'dislike',
          onTap: () {
            setState(() => loading = 'dislike');
            onVoteButtonTapped('dislike');
          },
        ),

        /// mine buttons
        if (widget.mine && widget.showReplyButton)
          CommonButton(
            child: Icon(FontAwesomeIcons.cog, size: md),
            onTap: () async {
              var res = await Get.bottomSheet(
                MineMenu(),
                backgroundColor: Colors.white,
              );
              if (res == 'update') widget.onUpdateTap();
              if (res == 'delete') widget.onDeleteTap();
            },
          ),
      ]),
    );
  }
}

class ForumButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool loading;

  ForumButton({
    this.label,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      showSpinner: loading,
      padding: EdgeInsets.only(right: sm),
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(fontSize: md, color: Colors.blue[500]),
      ),
    );
  }
}

class MineMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.height * .3,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(md),
              child: Text('Choose Action'),
            ),
            FlatButton(
              child: Text('update'.tr),
              onPressed: () {
                Get.back(result: 'update');
              },
            ),
            FlatButton(
              child: Text('delete'.tr),
              onPressed: () {
                Get.back(result: 'delete');
              },
            ),
            FlatButton(
              child: Text('close'.tr),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
