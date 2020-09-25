import 'package:flutter/material.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/post.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';
import 'package:get/get.dart';

class PostViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostModel post = Get.arguments;

    return Scaffold(
      appBar: CommonAppBar(title: Text('Post View')),
      endDrawer: CommonAppDrawer(),
      body: Container(
        child: Post(
          post: post,
        ),
      ),
    );
  }
}
