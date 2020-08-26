import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:get/get.dart';

class PostList extends StatelessWidget {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordpressController>(
      id: 'postList',
      builder: (_) {
        if (isEmpty(_.posts))
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('loading'.tr),
            ),
          );
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _.posts.length,
          itemBuilder: (context, i) {
            final post = _.posts[i];
            return ListTile(
              contentPadding: EdgeInsets.all(20),
              title: Text(post.title),
              subtitle: Column(
                children: [Text(post.content)],
              ),
            );
          },
        );
      },
    );
  }
}
