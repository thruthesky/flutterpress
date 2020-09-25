import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/post_view.title.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/file_display.dart';
import 'package:get/get.dart';

class PostView extends StatelessWidget {
  final PostModel post;
  final Function onUpdated;

  PostView({@required this.post, this.onUpdated});

  final WordpressController wc = Get.find();

  final double titleSize = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostViewHeader(
          post,
          onUpdateButtonTap: onUpdateTapped,
        ),
        FileDisplay(post.files),
      ],
    );
  }

  //// methods
  onUpdateTapped() async {
    var res = await Get.toNamed(
      Routes.postEdit,
      arguments: {'post': post},
    );
    if (!isEmpty(res)) {
      post.update(res);
      if (onUpdated != null) onUpdated();
    }
  }
}
