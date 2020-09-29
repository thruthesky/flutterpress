import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:get/get.dart';

class PostList extends StatelessWidget {
  PostList(this.posts);
  final List<PostModel> posts;
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return !isEmpty(posts)
        ? Column(
            key: ValueKey(Keys.postList),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// post list
              for (int i = 0; i <= posts.length - 1; i++)
                Post(post: posts[i], index: i)
            ],
          )
        : SizedBox.shrink();
  }
}
