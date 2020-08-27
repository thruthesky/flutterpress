import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
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

  updatePost(PostModel post) {
    widget.post.update(post);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.post.title),
            Text(widget.post.content),
            if (AppService.isMyPost(widget.post))
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Divider(),
                    RaisedButton(
                      child: Text('update'.tr),
                      onPressed: () async {
                        var res = await Get.toNamed(
                          AppRoutes.postEdit,
                          arguments: {'post': widget.post},
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
                              await wc.postDelete({'ID': widget.post.id});
                            } catch (e) {
                              AppService.error('$e'.tr);
                            }
                          },
                          onCancel: Get.back,
                        );
                      },
                    ),
                  ],
                ),
              ),

            /// TODO
            ///  - Comment CRUD
            if (AppService.wc.isUserLoggedIn)
              AppTextInputField(hintText: 'Comment')
          ],
        ),
      ),
    );
  }
}
