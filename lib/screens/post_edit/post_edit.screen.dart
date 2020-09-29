import 'package:flutter/material.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:get/get.dart';
import 'package:flutterpress/screens/post_edit/post_edit.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';

class PostEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = '';
    String slug = '';
    PostModel post;

    Map args = Get.arguments;
    if (args['slug'] != null) {
      slug = args['slug'];
      title = slug;
    } else {
      post = args['post'];
    }

    return Scaffold(
      key: ValueKey(Keys.postEditScreenScaffold),
      appBar: CommonAppBar(title: Text('$title')),
      endDrawer: CommonAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: PostEditForm(
            post: post,
            slug: slug,
          ),
        ),
      ),
    );
  }
}
