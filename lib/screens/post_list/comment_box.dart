import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';

class CommentBox extends StatelessWidget {
  final WordpressController wc = Get.find();

  final int parent;
  final int commentId;

  final PostModel post;

  final Function onEditted;
  final Function onCancel;

  final TextEditingController controller;

  CommentBox({
    @required this.post, // this should always have a value.
    this.parent = 0,
    this.commentId, // if this have value, it will update a comment.
    this.onCancel,
    this.onEditted(CommentModel comment), // emits whenever eddtiting is done.
    content, // should only have value when updating a comment.
  }) : controller = TextEditingController(text: content ?? '');

  onSubmit() async {
    if (isEmpty(controller.text)) return;

    var params = {
      'comment_content': controller.text,
      'comment_parent': parent,
    };

    if (!isEmpty(commentId)) {
      params['comment_ID'] = commentId.toString();
    } else {
      params['comment_post_ID'] = post.id.toString();
    }

    try {
      var res = await wc.commentEdit(params);
      controller.text = '';
      onEditted(res);
    } catch (e) {
      AppService.error('$e'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (!isEmpty(parent) || !isEmpty(commentId))
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(Icons.close),
            onTap: onCancel,
          ),
        ),
      Expanded(
        child: AppTextInputField(
          hintText: 'comment'.tr,
          inputType: TextInputType.text,
          inputAction: TextInputAction.done,
          controller: controller,
          sufficIcon: IconButton(icon: Icon(Icons.send), onPressed: onSubmit),
        ),
      ),
    ]);
  }
}
