import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/screens/post_list/post_list.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final WordpressController wc = Get.find();

  @override
  void initState() {
    wc.getPosts({});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.postListScaffold),
      appBar: AppBar(title: Text('postList'.tr)),
      endDrawer: AppDrawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (wc.user != null)
                RaisedButton(
                  key: ValueKey(AppKeys.postEditButton),
                  child: Text('createPost'.tr),
                  onPressed: () => Get.toNamed(AppRoutes.postEdit),
                ),
              PostList()
            ],
          ),
        ),
      ),
    );
  }
}
