import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/comment.dart';

class CommentList extends StatefulWidget {
  final PostModel post;

  CommentList({this.post});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  int commentsToShow = 1;

  @override
  void initState() {
    if (widget.post.comments.length > 5) {
      commentsToShow = 5;
    } else {
      commentsToShow =
          widget.post.comments.length != 0 ? widget.post.comments.length : 1;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.post.comments.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: xs),

              Text(
                'Comments $commentsToShow of ${widget.post.comments.length}',
              ),

              /// Comments
              for (var i = 0; i < commentsToShow; i++)
                Comment(
                  widget.post,
                  widget.post.comments[i],
                  onReplied: () {
                    commentsToShow++;
                    setState(() {});
                  },
                ),

              if (commentsToShow < widget.post.comments.length)
                GestureDetector(
                  child: Text('Show more comment'),
                  onTap: () {
                    commentsToShow += 5;
                    if (commentsToShow > widget.post.comments.length)
                      commentsToShow = widget.post.comments.length;

                    setState(() {});
                  },
                )
            ],
          )
        : SizedBox.shrink();
  }
}
