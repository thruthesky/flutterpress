import 'package:flutter/material.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/post_view.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';
import 'package:get/get.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  PostModel post;

  @override
  void initState() {
    post = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Text('Post View')),
      endDrawer: CommonAppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: PostView(
            post: post,
            onUpdated: () {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
