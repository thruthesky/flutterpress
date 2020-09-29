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
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final WordpressController wc = Get.find();

  final double titleSize = 20;

  PostModel post;

  bool inReply = false;

  @override
  void initState() {
    post = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostViewHeader(
          post,
          onUpdateButtonTap: onUpdateTapped,
          onDeleteButtonTap: onDeleteTapped,
        ),
        FileDisplay(post.files),
        Container(
          width: double.infinity,
          color: Color(0xFFF4F4F4),
          padding: EdgeInsets.all(md),
          child: SelectableText(
            post.content,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xDE000000),
            ),
          ),
        ),
        ForumButtons(
          showReplyButton: !inReply,
          padding: EdgeInsets.all(md),
          model: post,
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
              post: post,
              parent: post.id,
              onCancel: () => setState(() {
                inReply = false;
              }),
              onEditted: (comment) {
                post.insertComment(post.id, comment);
                inReply = false;
                setState(() {});
              },
            ),
          ),
        if (post.comments.length > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: md),
            child: CommentList(post: post),
          ),
        if (isEmpty(post.comments) && !inReply)
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
      arguments: {'post': post},
    );
    if (!isEmpty(res)) {
      post.update(res);
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
          await AppService.wc.postDelete({'ID': post.id});
          post.delete();
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
    );
  }
}
