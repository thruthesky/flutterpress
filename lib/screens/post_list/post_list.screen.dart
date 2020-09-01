import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post.list.dart';
import 'package:flutterpress/services/app.config.dart';
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

  ScrollController _scrollController = new ScrollController();

  String slug;
  List<PostModel> posts = [];

  bool loading = false;
  bool noMorePost = false;
  int page = 1;
  @override
  void initState() {
    loading = true;
    _scrollController.addListener(() {
      if (loading || noMorePost) return;

      /// @TODO: change from 0.9 (90%) to 250 from bottom.
      if (_scrollController.position.pixels >
          (0.9 * _scrollController.position.maxScrollExtent)) {
        loading = true;
        setState(() {});
        getPosts();
      }
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var args = routerArguments(context);
    slug = args == null ? '' : (args['slug'] ?? '');

    getPosts();
  }

  addOnTop(PostModel post) {
    posts.insert(0, post);
    setState(() {});
  }

  addPosts(List<dynamic> postData) {
    for (var p in postData) {
      posts.add(PostModel.fromBackendData(p));
    }
    loading = false;
    setState(() {});
  }

  getPosts() async {
    if (noMorePost) return;
    var re = await AppService.getHttp({
      'route': 'post.search',
      'slug': slug ?? '',
      'posts_per_page': AppConfig.noOfPostsPerPage,
      'paged': page
    });
    page += 1;

    if (re.length < AppConfig.noOfPostsPerPage) noMorePost = true;
    addPosts(re);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.postListScaffold),
      appBar: AppBar(
        title: Text('postList'.tr),
        actions: [
          if (wc.isUserLoggedIn)
            IconButton(
              key: ValueKey(AppKeys.postEditButton),
              icon: Icon(Icons.add),
              onPressed: () async {
                dynamic post = await Get.toNamed(
                  AppRoutes.postEdit,
                  arguments: {'slug': slug},
                );
                if (!isEmpty(post)) {
                  addOnTop(post);
                }
              },
            ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: AppDrawer(),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Column(
              children: [
                // if (wc.user != null)
                //   RaisedButton(
                //     key: ValueKey(AppKeys.postEditButton),
                //     child: Text('createPost'.tr),
                //     onPressed: () async {
                //       var post = await Get.toNamed(
                //         AppRoutes.postEdit,
                //         arguments: {'slug': slug},
                //       );
                //       if (!isEmpty(post)) {
                //         addOnTop(post);
                //       }
                //     },
                //   ),

                /// post list
                PostList(posts),

                /// loader
                if (loading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('loading'.tr),
                    ),
                  ),

                if (noMorePost)
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('noMorePost'.tr),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
