import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/screens/post_list/post.dart';
import 'package:get/get.dart';

class PostList extends StatelessWidget {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      id: 'postList',
      builder: (_) {
        var postList = _.posts;

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
          },
        );
      },
    );
  }
}
