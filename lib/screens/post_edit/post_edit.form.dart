import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';

class PostEditForm extends StatefulWidget {
  @override
  _PostEditFormState createState() => _PostEditFormState();
}

class _PostEditFormState extends State<PostEditForm> with AfterLayoutMixin {
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final content = TextEditingController();

  String slug;
  PostModel post;
  bool isUpdate = false;

  @override
  void initState() {
    if (!isEmpty(post)) {
      isUpdate = true;
      title.text = post.title;
      content.text = post.content;
    }
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var args = routerArguments(context);
    if (args['slug'] != null) {
      slug = args['slug'];
    } else {
      post = args['post'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            AppTextInputField(
              key: ValueKey(AppKeys.postTitleInput),
              hintText: 'title'.tr,
              controller: title,
              inputAction: TextInputAction.done,
            ),
            AppTextInputField(
              key: ValueKey(AppKeys.postContentInput),
              hintText: 'content'.tr,
              controller: content,
              inputAction: TextInputAction.done,
            ),
            RaisedButton(
              key: ValueKey(AppKeys.formSubmitButton),
              onPressed: () async {
                try {
                  var params = {
                    'slug': routerArguments(context)['slug'] ?? '',
                    'post_title': title.text,
                    'post_content': content.text,
                  };
                  if (isUpdate) params['ID'] = post.id.toString();
                  await wc.postEdit(params, isUpdate: isUpdate);
                  Get.back();
                } catch (e) {
                  AppService.error('$e'.tr);
                }
              },
              child: Text('submit'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
