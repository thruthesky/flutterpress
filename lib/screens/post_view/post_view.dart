import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/screens/post_view/forum_buttons.dart';
import 'package:flutterpress/screens/post_view/post_view.title.dart';
import 'package:flutterpress/services/app.service.dart';
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
          onDeleteButtonTap: onDeleteTapped,
        ),
        FileDisplay(post.files),
        Container(
          width: double.infinity,
          color: Color(0xFFF4F4F4),
          padding: EdgeInsets.all(md),
          child: SelectableText(post.content),
        ),
        ForumButtons(
          padding: EdgeInsets.all(md),
          model: post,
          onVoted: (vote) {
            post.updateVote(vote);
            if (onUpdated != null) onUpdated();
          },
        ),
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

  /// Delete
  onDeleteTapped() {
    AppService.confirmDialog(
      'delete'.tr,
      Text('confirmPostDelete'.tr),
      onConfirm: () async {
        try {
          await AppService.wc.postDelete({'ID': post.id});
          post.delete();
        } catch (e) {
          AppService.error('$e'.tr);
        }
      },
    );
  }
}
