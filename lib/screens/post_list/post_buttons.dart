import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class PostButtons extends StatelessWidget {
  final WordpressController wc = Get.find();

  final PostModel post;
  final Function onUpdate;
  final Function onDelete;

  PostButtons({
    this.post,
    this.onUpdate(PostModel post),
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Divider(),

          /// update
          RaisedButton(
            key: ValueKey(AppKeys.postUpdateButton),
            child: Text('update'.tr),
            onPressed: () async {
              var res = await Get.toNamed(
                AppRoutes.postEdit,
                arguments: {'post': post},
              );
              if (!isEmpty(res)) {
                onUpdate(res);
              }
            },
          ),

          /// delete
          RaisedButton(
            key: ValueKey(AppKeys.postDeleteButton),
            child: Text('delete'.tr),
            onPressed: () {
              AppService.confirmDialog(
                  'delete'.tr, Text('confirmPostDelete'.tr),
                  onConfirm: () async {
                try {
                  await wc.postDelete({'ID': post.id});
                  onDelete();
                } catch (e) {
                  AppService.error('$e'.tr);
                }
              }, onCancel: Get.back);
            },
          ),
        ],
      ),
    );
  }
}
