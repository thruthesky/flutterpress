import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post_list.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';
import 'package:flutterpress/widgets/commons/common.button.dart';
import 'package:get/get.dart';

/// TODO:
///   - implement pull to refresh
class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final WordpressController wc = Get.find();

  ScrollController _scrollController = ScrollController();

  String slug;
  List<PostModel> posts = [];

  bool loading = false;
  bool noMorePost = false;
  int page = 1;
  @override
  void initState() {
    var args = Get.arguments;
    slug = args ?? 'uncategorized';
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

  addOnTop(PostModel post) {
    posts.insert(0, post);
    setState(() {});
  }

  getPosts() async {
    if (loading) return;
    loading = true;
    setState(() {});
    if (noMorePost) return;

    List<PostModel> _ps = [];
    try {
      _ps = await AppService.wc.getPosts(slug: slug, page: page);
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.postListScaffold),
      appBar: CommonAppBar(
        title: Text('postList'.tr),
        actions: wc.isUserLoggedIn
            ? [
                CommonButton(
                  key: ValueKey(Keys.postEditButton),
                  child: Icon(Icons.edit, size: 24),
                  padding: EdgeInsets.only(right: sm),
                  onTap: () async {
                    var post = await Get.toNamed(
                      Routes.postEdit,
                      arguments: {'slug': slug},
                    );
                    if (!isEmpty(post)) {
                      addOnTop(post);
                    }
                  },
                ),
                CommonButton(
                  child: Icon(Icons.search, size: 24),
                  padding: EdgeInsets.only(right: sm),
                  onTap: () {},
                ),
              ]
            : null,
      ),
      endDrawer: CommonAppDrawer(),
      body: SafeArea(
        child: Container(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: PostList(
                posts,
                loading: loading,
                noMorePost: noMorePost,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
