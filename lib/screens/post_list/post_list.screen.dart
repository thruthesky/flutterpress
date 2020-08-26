import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/screens/post_list/post_list.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen>
    with AfterLayoutMixin<PostListScreen> {
  final WordpressController wc = Get.find();

  String slug;
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var args = routerArguments(context);
    slug = args == null ? '' : (args['slug'] ?? '');

    getPosts();
  }

  /// This adds a single post to a list.
  ///
  /// This is used under [postEdit] and [getPost] method.
  addPosts(List<dynamic> postData) {
    for (var p in postData) {
      posts.add(PostModel.fromBackendData(p));
    }
    setState(() {});
  }

  getPosts() async {
    var re = await AppService.getHttp({
      'route': 'post.search',
      'slug': slug ?? '',
    });
    addPosts(re);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.postListScaffold),
      appBar: AppBar(title: Text('postList'.tr)),
      endDrawer: AppDrawer(),
      body: Container(
        child: SingleChildScrollView(
          // scroll listener
          child: Column(
            children: [
              if (wc.user != null)
                RaisedButton(
                  key: ValueKey(AppKeys.postEditButton),
                  child: Text('createPost'.tr),
                  onPressed: () => Get.toNamed(AppRoutes.postEdit,
                      arguments: {'slug': slug}),
                ),
              PostList(posts),
            ],
          ),
        ),
      ),
    );
  }
}
