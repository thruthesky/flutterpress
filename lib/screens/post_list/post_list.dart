import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/screens/post_list/post.dart';
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
    var postList = widget.posts;

    if (isEmpty(postList))
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('loading'.tr),
        ),
      );

    return ListView.builder(
        shrinkWrap: true,
        itemCount: postList.length,
        itemBuilder: (context, i) {
          final post = postList[i];
          return Post(post: post);
        });
  }
}
