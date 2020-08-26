import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class Post extends StatelessWidget {
  final WordpressController wc = Get.find();
  final PostModel post;

  Post({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      title: Text(post.title),
      subtitle: Column(
        children: [
          Text(post.content),
          if (post.authorId == wc.user.id)
            Row(
              children: [
                RaisedButton(
                  child: Text('update'.tr),
                  onPressed: () => Get.toNamed(
                    AppRoutes.postEdit,
                    arguments: post,
                  ),
                ),
                RaisedButton(
                  child: Text('delete'.tr),
                  onPressed: () {
                    AppService.confirmDialog(
                      'delete'.tr,
                      Text('confirmPostDelete'.tr),
                      onConfirm: () async {
                        Get.back();
                        try {
                          await wc.postDelete({'ID': post.id});
                        } catch (e) {
                          AppService.error('$e'.tr);
                        }
                      },
                      onCancel: Get.back,
                    );
                  },
                )
              ],
            )
        ],
      ),
    );
  }
}
