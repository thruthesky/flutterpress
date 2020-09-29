import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/post_list/post.view.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post.tile.dart';

class Post extends StatefulWidget {
  Post({this.post, this.index});

  final PostModel post;
  final int index;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: widget.index == 0 ? 0 : sm,
      ),
      color: Colors.white,
      child: widget.post.isInView
          ? PostView(post: widget.post)
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: PostTile(post: widget.post),
              onTap: () {
                widget.post.isInView = true;
                setState(() {});
              },
            ),
    );
  }
}
