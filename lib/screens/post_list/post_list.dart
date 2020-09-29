import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_list/post.tile.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:get/get.dart';

class PostList extends StatelessWidget {
  PostList(
    this.posts, {
    this.loading,
    this.noMorePost,
    this.hidePostID,
  });
  final int hidePostID;
  final List<PostModel> posts;
  final bool loading, noMorePost;
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return !isEmpty(posts)
        ? Column(
            key: ValueKey(Keys.postList),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// post list
              for (PostModel post in posts)
                if (hidePostID != post.id)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: PostTile(post: post),
                    onTap: () {
                      Get.toNamed(Routes.postView, arguments: post, preventDuplicates: false);
                    },
                  ),

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
          )
        : SizedBox.shrink();
  }
}
