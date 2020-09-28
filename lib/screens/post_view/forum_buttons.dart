import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/forum_base.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/commons/common.button.dart';
import 'package:get/get.dart';

class ForumButtons extends StatefulWidget {
  final ForumBaseModel model;

  final bool showReplyButton;

  final Function onReplyTap;
  final Function onVoted;
  final EdgeInsets padding;
  final double textSize;

  ForumButtons({
    @required this.model,
    this.showReplyButton = false,
    this.onReplyTap,
    @required this.onVoted,
    this.padding = const EdgeInsets.only(top: 10),
    this.textSize,
  });

  @override
  _ForumButtonsState createState() => _ForumButtonsState();
}

class _ForumButtonsState extends State<ForumButtons> {
  String loading;
  bool mine;

  @override
  void initState() {
    mine = AppService.isMine(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var likeText = widget.model.like > 0
        ? 'like'.tr + '(${widget.model.like})'
        : 'like'.tr;
    var dislikeText = widget.model.dislike > 0
        ? 'dislike'.tr + '(${widget.model.dislike})'
        : 'dislike'.tr;

    return Container(
      padding: widget.padding,
      child: Row(children: [
        if (widget.showReplyButton && AppService.wc.isUserLoggedIn)
          ForumButton(
            label: 'reply'.tr,
          labelSize: widget.textSize,
            onTap: widget.onReplyTap,
          ),
        ForumButton(
          label: likeText,
          labelSize: widget.textSize,
          loading: loading == 'like',
          onTap: () {
            onVoteButtonTapped('like');
          },
        ),
        ForumButton(
          label: dislikeText,
          labelSize: widget.textSize,
          loading: loading == 'dislike',
          onTap: () {
            onVoteButtonTapped('dislike');
          },
        ),
      ]),
    );
  }

  /// METHODS ///

  /// Vote
  onVoteButtonTapped(String choice) async {
    if (mine) {
      AppService.error(
          widget.model.isPost ? 'errVoteOwnPost'.tr : 'errVoteOwnComment'.tr);
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
        final params = {'choice': choice, 'ID': widget.model.id};
        if (widget.model.isPost) {
          vote = await AppService.wc.postVote(params);
        } else {
          vote = await AppService.wc.commentVote(params);
        }
        widget.model.updateVote(vote);
        widget.onVoted();
        setState(() => loading = null);
      } catch (e) {
        AppService.error(e);
        setState(() => loading = null);
      }
    }
  }
}

class ForumButton extends StatelessWidget {
  final String label;
  final double labelSize;
  final Function onTap;
  final bool loading;

  ForumButton({
    this.label,
    this.onTap,
    this.labelSize = sm,
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
        style: TextStyle(fontSize: labelSize, color: Colors.blue[500]),
      ),
    );
  }
}
