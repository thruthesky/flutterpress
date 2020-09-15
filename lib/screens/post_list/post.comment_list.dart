import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/comment.dart';

class CommentList extends StatefulWidget {
  final PostModel post;

  CommentList({this.post});

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  int commentsToShow;

  @override
  void initState() {
    if (widget.post.comments.length > 5) {
      commentsToShow = 5;
    } else {
      commentsToShow = widget.post.comments.length;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: xs),

        if (widget.post.comments.length > 0)
          Text('Comments $commentsToShow of ${widget.post.comments.length}'),

        /// Comments
        for (var i = 0; i < commentsToShow; i++)
          Comment(
            widget.post,
            widget.post.comments[i],
            onReplied: () {
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
    );
  }
}
