import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/comment.content.dart';
import 'package:flutterpress/screens/post_list/comment.header.dart';
import 'package:flutterpress/screens/post_list/forum_buttons.dart';
import 'package:flutterpress/screens/post_list/mine_button.dart';
import 'package:flutterpress/services/app.service.dart';
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
        top: 10,
        bottom: 10,
        left: widget.comment.depth != 1
            ? (widget.comment.depth * 5).toDouble()
            : 0,
      ),
      padding: EdgeInsets.all(sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF4F4F4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// comment header
          CommentHeader(comment: widget.comment),

          if (!widget.comment.deleted) ...[
            /// comment contents
            if (!inEdit) CommentContent(comment: widget.comment),

            Divider(
              color: Color(0xFFDDDDDD),
              thickness: 1,
            ),

            /// comment buttons
            if (!inEdit)
              Row(
                children: [
                  ForumButtons(
                    model: widget.comment,
                    showReplyButton: !inReply,
                    onReplyTap: () => changeInReplyState(true),
                    onVoted: () => setState(() {}),
                    padding: null,
                  ),
                  Spacer(),
                  if (AppService.isMine(widget.comment))
                  MineButton(
                    onSelect: (option) {
                      if (option == MineOption.update)
                        setState(() {
                          inEdit = true;
                        });
                      if (option == MineOption.delete) onDeleteTapped();
                    },
                  ),
                ],
              ),

            /// comment contents in edit mode
            if (inEdit)
              CommentBox(
                post: widget.post,
                comment: widget.comment,
                onCancel: () => changeInEditState(false),
                onEditted: (comment) {
                  widget.comment.update(comment);
                  changeInEditState(false);
                  setState(() {});
                },
              ),
          ],

          /// Reply box
          if (inReply) ...[
            SizedBox(height: sm),
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

  /// Delete
  onDeleteTapped() {
    AppService.confirmDialog(
      'delete'.tr,
      Text('confirmPostDelete'.tr),
      onConfirm: () async {
        try {
          await AppService.wc.commentDelete({'comment_ID': widget.comment.id});
          widget.comment.delete();
          setState(() {});
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
    );
  }
}
