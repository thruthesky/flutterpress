import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post.tile.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:get/get.dart';

class PostList extends StatefulWidget {
  PostList(this.posts);
  final List<PostModel> posts;
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return !isEmpty(widget.posts)
        ? Column(
            key: ValueKey(Keys.postList),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (PostModel post in widget.posts)
                GestureDetector(
                  child: PostTile(post: post),
                  onTap: () {
                    Get.toNamed(Routes.postView, arguments: post);
                  },
                )
            ],
          )
        : SizedBox.shrink();
  }
}
