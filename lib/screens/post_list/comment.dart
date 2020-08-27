import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/comment_buttons.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;
  final PostModel post;

  Comment(this.post, this.comment);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final WordpressController wc = Get.find();

  bool inEdit = false;

  changeInEditState(bool val) {
    inEdit = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin: EdgeInsets.only(top: 20, left: 10),
      child: inEdit
          ? CommentBox(
              post: widget.post,
              content: widget.comment.content,
              commentId: widget.comment.id,
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
                  subtitle: Text(widget.comment.content),
                ),

                /// comment buttons
                CommentButtons(
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
