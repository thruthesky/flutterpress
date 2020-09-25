import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/comment_box.dart';
import 'package:flutterpress/screens/post_view/forum_buttons.dart';
import 'package:flutterpress/screens/post_view/post.comment_list.dart';
import 'package:flutterpress/screens/post_view/post.content.dart';
import 'package:flutterpress/screens/post_view/post.header.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget {
  final PostModel post;

  Post({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(Keys.post),
      margin: EdgeInsets.only(top: sm, left: sm, right: sm),
      child: Container(
        padding: EdgeInsets.all(sm),
        child: Column(
          children: [
            /// post header (user avatar, title)
            PostHeader(post: widget.post),

            if (!widget.post.deleted) ...[
              /// post content
              PostContent(post: widget.post),

              /// post buttons
              ForumButtons(
                model: widget.post,
                showReplyButton: false,
                onUpdateTap: onUpdateTapped,
                onDeleted: () => setState(() {}),
                onVoted: () => setState(() {}),
              ),

              /// comment box
              if (AppService.wc.isUserLoggedIn)
                CommentBox(
                  post: widget.post,
                  onEditted: (comment) {
                    widget.post.insertComment(0, comment);
                    setState(() {});
                  },
                ),
            ],

            /// comment list
            CommentList(post: widget.post)
          ],
        ),
      ),
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
      if (mounted) setState(() {});
    }
  }
}
