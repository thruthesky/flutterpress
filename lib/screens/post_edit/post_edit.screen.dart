import 'package:flutter/material.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:get/get.dart';
import 'package:flutterpress/screens/post_edit/post_edit.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';

class PostEditScreen extends StatefulWidget {
  @override
  _PostEditScreenState createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  String title = '';
  String slug = '';
  PostModel post;

  @override
  void initState() {
    Map args = Get.arguments;
    if (args['slug'] != null) {
      slug = args['slug'];
      title = slug;
    } else {
      post = args['post'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
