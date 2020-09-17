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

  final bool mine;
  final bool isComment;
  final bool showReplyButton;

  final int likeCount;
  final int dislikeCount;

  final Function onReplyTap;
  final Function onUpdateTap;
  final Function onDeleted;
  final Function onVoted;

  ForumButtons({
    @required this.parentID,
    this.mine,
    this.isComment = false,
    this.showReplyButton = false,
    this.likeCount = 0,
    this.dislikeCount = 0,
    this.onReplyTap,
    @required this.onUpdateTap,
    @required this.onDeleted,
    @required this.onVoted(VoteModel vote),
  });

  @override
  _ForumButtonsState createState() => _ForumButtonsState();
}

class _ForumButtonsState extends State<ForumButtons> {
  String loading;

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
        if (widget.showReplyButton && AppService.wc.isUserLoggedIn)
          ForumButton(
            label: 'reply'.tr,
            onTap: widget.onReplyTap,
          ),
        ForumButton(
          label: likeText,
          loading: loading == 'like',
          onTap: () {
            onVoteButtonTapped('like');
          },
        ),
        ForumButton(
          label: dislikeText,
          loading: loading == 'dislike',
          onTap: () {
            onVoteButtonTapped('dislike');
          },
        ),

        /// mine buttons
        if (widget.mine)
          CommonButton(
            child: Icon(FontAwesomeIcons.cog, size: md),
            onTap: () async {
              var res = await Get.bottomSheet(
                MineMenu(),
                backgroundColor: Colors.white,
              );
              if (res == 'update') widget.onUpdateTap();
              if (res == 'delete') onDeleteButtonTapped();
            },
          ),
      ]),
    );
  }

  /// METHODS ///

  /// Vote
  onVoteButtonTapped(String choice) async {
    if (widget.mine) {
      AppService.error(
        'You can\'t vote on your own ${widget.isComment ? 'comment' : 'post'}',
      );
      return;
    }

    if (loading != null) return;
    setState(() => loading = choice);

    if (!AppService.wc.isUserLoggedIn) {
      setState(() => loading = null);
      AppService.confirmDialog(
        'error'.tr,
        Text('Login first to vote'),
        textConfirm: 'login'.tr,
        onConfirm: () => Get.toNamed(Routes.login),
        onCancel: () {
          return;
        },
      );
    } else {
      try {
        var vote;
        final params = {'choice': choice, 'ID': widget.parentID};
        if (widget.isComment) {
          vote = await AppService.wc.commentVote(params);
        } else {
          vote = await AppService.wc.postVote(params);
        }
        widget.onVoted(vote);
        setState(() => loading = null);
      } catch (e) {
        AppService.error(e);
        setState(() => loading = null);
      }
    }
  }

  /// Delete
  onDeleteButtonTapped() {
    AppService.confirmDialog(
      'delete'.tr,
      Text('confirmPostDelete'.tr),
      onConfirm: () async {
        try {
          if (widget.isComment) {
            await AppService.wc.commentDelete({'comment_ID': widget.parentID});
          } else {
            await AppService.wc.postDelete({'ID': widget.parentID});
          }
          widget.onDeleted();
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
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
