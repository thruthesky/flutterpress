import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment_box.dart';
import 'package:flutterpress/screens/post_list/forum_buttons.dart';
import 'package:flutterpress/screens/post_list/post.comment_list.dart';
import 'package:flutterpress/screens/post_list/post_header.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(Keys.post),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// post content (user avatar, title)
            PostHeader(post: widget.post),

            SizedBox(height: sm),
            if (!isEmpty(widget.post.content))
              SelectableText(widget.post.content),
            FileDisplay(widget.post.files),

            Divider(),

            /// post buttons
            if (!widget.post.deleted)
              ForumButtons(
                parentID: widget.post.id,
                inEdit: false,
                showReplyButton: false,
                likeCount: widget.post.like,
                dislikeCount: widget.post.dislike,
                mine: AppService.isMine(widget.post),
                onDeleteTap: onDeleteTapped,
                onUpdateTap: onUpdateTapped,
                onVoted: (vote) {
                  widget.post.updateVote(vote);
                  setState(() {});
                },
              ),

            /// comment box
            if (AppService.wc.isUserLoggedIn && !widget.post.deleted)
              CommentBox(
                  post: widget.post,
                  onEditted: (comment) {
                    widget.post.insertComment(0, comment);
                    setState(() {});
                  }),

            /// comment list
            if (!isEmpty(widget.post.comments.length))
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

  onDeleteTapped() {
    AppService.confirmDialog('delete'.tr, Text('confirmPostDelete'.tr),
        onConfirm: () async {
      try {
        await AppService.wc.postDelete({'ID': widget.post.id});
        widget.post.delete();
        if (mounted) setState(() {});
      } catch (e) {
        AppService.error('$e'.tr);
      }
    });
  }

  onVoteTapped(String choice) async {
    try {
      var vote = await AppService.wc.postVote({
        'choice': choice,
        'ID': widget.post.id,
      });
      widget.post.updateVote(vote);
      if (mounted) setState(() {});
    } catch (e) {
      AppService.error(e);
    }
  }
}
