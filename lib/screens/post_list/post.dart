import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/screens/post_list/comment.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/post_buttons.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/file_display.dart';
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
    if (mounted) setState(() {});
  }

  onPostDeleted() {
    widget.post.delete();
    if (mounted) setState(() {});
  }

  onPostVoted(VoteModel vote) {
    widget.post.updateVote(vote);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(Keys.post),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.post.title),
            if (!isEmpty(widget.post.content)) Text(widget.post.content),
            Divider(),

            /// post images
            FileDisplay(widget.post.files),

            /// post buttons
            if (AppService.wc.isUserLoggedIn)
              PostButtons(
                post: widget.post,
                onUpdate: onPostUpdated,
                onDelete: onPostDeleted,
                onVoted: onPostVoted,
              ),

            /// comment box
            if (AppService.wc.isUserLoggedIn && !widget.post.deleted)
              CommentBox(
                  post: widget.post,
                  onEditted: (comment) {
                    widget.post.insertComment(0, comment);
                    setState(() {});
                  }),

            /// Comments
            if (!isEmpty(widget.post.comments.length))
              for (CommentModel comment in widget.post.comments)
                Comment(
                  widget.post,
                  comment,
                  onReplied: () {
                    setState(() {});
                  },
                )
          ],
        ),
      ),
    );
  }
}
