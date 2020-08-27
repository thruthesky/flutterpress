import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/screens/post_list/comment.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/post_buttons.dart';
import 'package:flutterpress/services/app.service.dart';
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

  onPostUpdated(PostModel post) {
    widget.post.update(post);
    setState(() {});
  }

  onPostDeleted() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.post.title),
            Text(widget.post.content),
            Divider(),

            /// post buttons
            if (AppService.isMyPost(widget.post))
              PostButtons(
                post: widget.post,
                onUpdate: onPostUpdated,
                onDelete: onPostDeleted,
              ),

            /// TODO: comment box
            ///
            ///  - Comment CRUD
            if (AppService.wc.isUserLoggedIn && !widget.post.deleted)
              CommentBox(
                  post: widget.post,
                  onEditted: (comment) {
                    widget.post.insertComment(0, comment);
                    setState(() {});
                  }),

            /// Comments
            ///
            /// TODO: seperate to widget
            if (!isEmpty(widget.post.comments.length))
              for (CommentModel comment in widget.post.comments)
                Comment(widget.post, comment)
          ],
        ),
      ),
    );
  }
}
