import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/comment_header.dart';
import 'package:flutterpress/screens/post_list/forum_buttons.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/file_display.dart';
import 'package:get/get.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;
  final PostModel post;
  final Function onReplied;

  Comment(this.post, this.comment, {this.onReplied});

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final WordpressController wc = Get.find();

  bool inEdit = false;
  bool inReply = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: widget.comment.depth != 1
            ? (widget.comment.depth * 5).toDouble()
            : 0,
      ),
      padding: EdgeInsets.all(xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// comment header
          CommentHeader(comment: widget.comment),

          /// comment contents
          SizedBox(height: sm),
          SelectableText(widget.comment.content),
          FileDisplay(widget.comment.files),

          /// comment buttons
          if (!widget.comment.deleted)
            ForumButtons(
              mine: AppService.isMine(widget.comment),
              inEdit: inEdit,
              showReplyButton: !inReply,
              likeCount: widget.comment.like,
              dislikeCount: widget.comment.dislike,
              onVoteTap: onVoteTapped,
              onDeleteTap: onDeleteTapped,
              onReplyTap: () => changeInReplyState(true),
              onUpdateTap: () => changeInEditState(true),
            ),

          /// Reply box
          if (inReply)
            CommentBox(
              post: widget.post,
              parent: widget.comment.id,
              onCancel: () => changeInReplyState(false),
              onEditted: (comment) {
                widget.post.insertComment(widget.comment.id, comment);
                changeInReplyState(false);
                widget.onReplied();
              },
            ),
        ],
      ),
    );
  }

  //// methods

  changeInEditState(bool val) {
    inEdit = val;
    setState(() {});
  }

  changeInReplyState(bool val) {
    inReply = val;
    setState(() {});
  }

  onDeleteTapped() {
    AppService.confirmDialog(
      'delete'.tr,
      Text('confirmDelete'.tr),
      onConfirm: () async {
        try {
          await wc.commentDelete(
            {'comment_ID': widget.comment.id},
          );
          widget.comment.delete();
          setState(() {});
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
    );
  }

  onVoteTapped(String choice) async {
    try {
      var vote = await AppService.wc.commentVote({
        'choice': choice,
        'ID': widget.comment.id,
      });
      widget.comment.updateVote(vote);
      if (mounted) setState(() {});
    } catch (e) {
      AppService.error(e);
    }
  }
}
