import 'package:after_layout/after_layout.dart';
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
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:get/get.dart';

/// TODO:
///   - implement pull to refresh
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

      if (_scrollController.position.pixels >
          (_scrollController.position.maxScrollExtent - 250)) {
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

  addPosts(Map<String, dynamic> postData) {
    postData.forEach((key, value) {
      posts.add(PostModel.fromBackendData(value));
    });
    loading = false;
    setState(() {});
  }

  getPosts() async {
    if (noMorePost) return;

    Map<String, dynamic> re;
    try {
      re = await AppService.getHttp({
        'route': 'post.search',
        'slug': slug ?? '',
        'posts_per_page': AppConfig.noOfPostsPerPage,
        'paged': page
      });
      re.remove('route');
    } catch (e) {
      AppService.error(e);
    }

    if (isEmpty(re)) return;
    page += 1;

    if (re.length < AppConfig.noOfPostsPerPage) noMorePost = true;
    addPosts(re);
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
      body: Container(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                children: [
                  /// post list
                  PostList(posts),

                  /// loader
                  if (loading && !noMorePost)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: lg),
                        child: CommonSpinner(),
                      ),
                    ),

                  if (noMorePost)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('noMorePost'.tr),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
