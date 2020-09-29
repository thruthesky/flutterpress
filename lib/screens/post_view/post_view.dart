import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/comment_box.dart';
import 'package:flutterpress/screens/post_view/forum_buttons.dart';
import 'package:flutterpress/screens/post_view/post.comment_list.dart';
import 'package:flutterpress/screens/post_view/post_view.header.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/file_display.dart';
import 'package:flutterpress/widgets/no_comments.dart';
import 'package:get/get.dart';

class PostView extends StatefulWidget {
  PostView(this.post);

  final PostModel post;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final WordpressController wc = Get.find();

  final double titleSize = 20;

  bool inReply = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostViewHeader(
          widget.post,
          onUpdateButtonTap: onUpdateTapped,
          onDeleteButtonTap: onDeleteTapped,
        ),
        FileDisplay(widget.post.files),
        Container(
          width: double.infinity,
          color: Color(0xFFF4F4F4),
          padding: EdgeInsets.all(md),
          child: SelectableText(
            widget.post.content,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xDE000000),
            ),
          ),
        ),
        ForumButtons(
          showReplyButton: !inReply,
          padding: EdgeInsets.all(md),
          model: widget.post,
          onVoted: () {
            setState(() {});
          },
          onReplyTap: () => setState(() {
            inReply = true;
          }),
        ),
        if (inReply)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: md),
            child: CommentBox(
              post: widget.post,
              parent: widget.post.id,
              onCancel: () => setState(() {
                inReply = false;
              }),
              onEditted: (comment) {
                widget.post.insertComment(widget.post.id, comment);
                inReply = false;
                setState(() {});
              },
            ),
          ),
        if (widget.post.comments.length > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: md),
            child: CommentList(post: widget.post),
          ),
        if (isEmpty(widget.post.comments) && !inReply)
          NoComments(
            onCreateTap: () => setState(() {
              inReply = true;
            }),
          ),
      ],
    );
  }

  //// methods
  onUpdateTapped() async {
    var res = await Get.toNamed(
      Routes.postEdit,
      arguments: {'post': widget.post},
    );
    if (!isEmpty(res)) {
      widget.post.update(res);
      setState(() {});
    }
  }

  /// Delete
  onDeleteTapped() {
    AppService.confirmDialog(
      'delete'.tr,
      Text('confirmPostDelete'.tr),
      onConfirm: () async {
        try {
          await AppService.wc.postDelete({'ID': widget.post.id});
          widget.post.delete();
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
    );
  }
}
