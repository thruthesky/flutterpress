import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';

class CommentBox extends StatefulWidget {
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

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final WordpressController wc = Get.find();

  bool loading = false;
  bool submittable;

  @override
  initState() {
    submittable = !isEmpty(widget.controller.text);

    super.initState();
  }

  onSubmit() async {
    if (isEmpty(widget.controller.text) || loading) return;

    loading = true;
    setState(() {});

    var params = {
      'comment_content': widget.controller.text,
      'comment_parent': widget.parent,
    };

    if (!isEmpty(widget.commentId)) {
      params['comment_ID'] = widget.commentId.toString();
    } else {
      params['comment_post_ID'] = widget.post.id.toString();
    }

    try {
      var res = await wc.commentEdit(params);
      widget.controller.text = '';
      widget.onEditted(res);
      loading = false;
      if (mounted) setState(() {});
    } catch (e) {
      loading = false;
      setState(() {});
      AppService.error('$e'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: AppTextInputField(
          hintText: 'comment'.tr,
          inputType: TextInputType.text,
          inputAction: TextInputAction.done,
          controller: widget.controller,
          autoValidate: true,
          icon: (!isEmpty(widget.parent) || !isEmpty(widget.commentId))
              ? IconButton(icon: Icon(Icons.close), onPressed: widget.onCancel)
              : null,
          sufficIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: isEmpty(widget.controller.text) ? null : onSubmit,
          ),
          onChanged: (value) {
            setState(() {});
          }
        ),
      ),
    ]);
  }
}
