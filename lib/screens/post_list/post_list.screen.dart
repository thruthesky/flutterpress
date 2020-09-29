import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/no_posts.dart';
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

class _PostListScreenState extends State<PostListScreen> {
  final WordpressController wc = Get.find();

  ScrollController _scrollController = ScrollController();

  String slug;
  List<PostModel> posts = [];

  bool loading = true;
  bool noMorePost = false;
  bool noPosts = false;

  int page = 1;
  @override
  void initState() {
    var args = Get.arguments;
    slug = args ?? 'uncategorized';

    getPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          (_scrollController.position.maxScrollExtent - 250)) {
        if (loading || noMorePost) return;
        loading = true;
        setState(() {});
        getPosts();
      }
    });
    super.initState();
  }

  addPosts(List<PostModel> ps) {
    if (ps.length < AppConfig.noOfPostsPerPage) noMorePost = true;
    ps.forEach((p) => posts.add(p));
    loading = false;
    setState(() {});
  }

  addOnTop(PostModel post) {
    posts.insert(0, post);
    setState(() {});
  }

  getPosts() async {
    List<PostModel> _ps = [];
    try {
      _ps = await AppService.wc.getPosts(slug: slug, page: page);
    } catch (e) {
      AppService.alertError(e);
    }

    if (isEmpty(_ps)) {
      if (page == 1)
        setState(() {
          noPosts = true;
        });
      return;
    }
    page += 1;
    addPosts(_ps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.postListScaffold),
      appBar: CommonAppBar(
        title: Text('$slug'.tr),
        actions: wc.isUserLoggedIn
            ? [
                CommonButton(
                  key: ValueKey(Keys.postEditButton),
                  child: Icon(Icons.edit, size: 24),
                  padding: EdgeInsets.only(right: sm),
                  onTap: () async {
                    if (!wc.user.hasMobile) {
                      return AppService.alertError('err_update_mobile'.tr);
                    }

                    if (!wc.user.hasNickname) {
                      return AppService.alertError('err_update_nickname'.tr);
                    }

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
          color: Color(0x01000000),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: noPosts
                  ? NoPosts()
                  : Column(
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
