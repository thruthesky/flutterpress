import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/comment_content.dart';
import 'package:flutterpress/screens/post_list/forum_buttons.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularAvatar(
                photoURL: widget.comment.authorPhotoUrl,
                height: 45,
                width: 45,
              ),
              SizedBox(width: xs),

              /// comment content
              if (!inEdit)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommentContent(comment: widget.comment),
                      if (!widget.comment.deleted)
                        ForumButtons(
                          mine: AppService.isMine(widget.comment),
                          inEdit: inEdit,
                          showReplyButton: inReply,
                          likeCount: widget.comment.like,
                          dislikeCount: widget.comment.dislike,
                          onVoteTap: onVoteTapped,
                          onDeleteTap: onDeleteTapped,
                          onReplyTap: () => changeInReplyState(true),
                          onUpdateTap: () => changeInEditState(true),
                        ),
                    ],
                  ),
                ),

              if (inEdit)
                Expanded(
                  child: CommentBox(
                    post: widget.post,
                    comment: widget.comment,
                    onCancel: () => changeInEditState(false),
                    onEditted: (comment) {
                      widget.comment.update(comment);
                      changeInEditState(false);
                      setState(() {});
                    },
                  ),
                ),
            ],
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
