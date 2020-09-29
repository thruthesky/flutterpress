import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post_list.dart';
import 'package:flutterpress/screens/post_view/post_view.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';
import 'package:get/get.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  ScrollController _scrollController = ScrollController();

  List<PostModel> posts = [];

  bool loading = false;
  bool noMorePost = false;
  int page = 1;

  PostModel post;

  getPosts() async {
    if (loading) return;

    loading = true;
    setState(() {});
    if (noMorePost) return;

    List<PostModel> _ps = [];
    try {
      _ps = await AppService.wc.getPosts(slug: post.slug, page: page);
    } catch (e) {
      AppService.alertError(e);
    }

    if (isEmpty(_ps)) return;
    page += 1;

    if (_ps.length < AppConfig.noOfPostsPerPage) noMorePost = true;
    _ps.forEach((p) => posts.add(p));
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    post = Get.arguments;

    getPosts();
    _scrollController.addListener(() {
      if (loading || noMorePost) return;

      if (_scrollController.position.pixels >
          (_scrollController.position.maxScrollExtent - 250)) {
        getPosts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: Text('Post View')),
      endDrawer: CommonAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                PostView(post),
                SizedBox(height: xxl),
                PostList(
                  posts,
                  hidePostID: post.id,
                  loading: loading,
                  noMorePost: noMorePost,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
