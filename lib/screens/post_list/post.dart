import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget {
  final PostModel post;

  Post({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final WordpressController wc = Get.find();
  PostModel post;

  updatePost(PostModel post) {
    post = post;
    setState(() {});
  }

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      title: Text(post.title),
      subtitle: Column(
        children: [
          Text(post.content),
          if (AppService.isMyPost(post))
            Row(
              children: [
                RaisedButton(
                  child: Text('update'.tr),
                  onPressed: () async {
                    var res = await Get.toNamed(
                      AppRoutes.postEdit,
                      arguments: {'post': post},
                    );
                    if (!isEmpty(res)) {
                      updatePost(res);
                    }
                  },
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
