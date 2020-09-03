import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/comment_buttons.dart';
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

  changeInEditState(bool val) {
    inEdit = val;
    setState(() {});
  }

  changeInReplyState(bool val) {
    inReply = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin:
          EdgeInsets.only(top: 20, left: 10 * widget.comment.depth.toDouble()),
      child: inEdit
          ? CommentBox(
              post: widget.post,
              comment: widget.comment,
              onCancel: () => changeInEditState(false),
              onEditted: (comment) {
                widget.comment.update(comment);
                changeInEditState(false);
                setState(() {});
              },
            )
          : Column(
              children: [
                ListTile(
                  title: Text(widget.comment.author),
                  subtitle: !isEmpty(widget.comment.content)
                      ? Text(widget.comment.content)
                      : null,
                ),

                /// File Display
                if (!inEdit) FileDisplay(widget.comment.files, inEdit: inEdit),

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

                /// comment buttons
                if (wc.isUserLoggedIn && !inReply && !widget.comment.deleted)
                  CommentButtons(
                    comment: widget.comment,
                    onReplyTap: () => changeInReplyState(true),
                    onUpdateTap: () => changeInEditState(true),
                    onDeleteTap: () {
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
                        onCancel: Get.back,
                      );
                    },
                  )
              ],
            ),
    );
  }
}
