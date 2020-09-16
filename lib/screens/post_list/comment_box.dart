import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:flutterpress/widgets/file_display.dart';
import 'package:flutterpress/widgets/file_upload_button.dart';
import 'package:get/get.dart';

class CommentBox extends StatefulWidget {
  final int parent;
  final CommentModel comment;

  final PostModel post;

  final Function onEditted;
  final Function onCancel;

  CommentBox({
    @required this.post, // this should always have a value.
    this.parent = 0,
    comment, // if this have value, it will update a comment.
    this.onCancel,
    this.onEditted(CommentModel comment), // emits whenever eddtiting is done.
  }) : this.comment = comment ?? CommentModel();

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final WordpressController wc = Get.find();
  TextEditingController controller;

  final focusNode = FocusNode();

  bool loading = false;
  double uploadProgress = 0;

  @override
  initState() {
    controller = TextEditingController(text: widget.comment.content);
    if (!isEmpty(widget.parent) || !isEmpty(widget.comment.id)) {
      focusNode.requestFocus();
    }
    super.initState();
  }

  onSubmit() async {
    if (isEmpty(controller.text) || loading) return;

    loading = true;
    setState(() {});

    var params = {
      'comment_content': controller.text,
      'comment_parent': widget.parent,
    };

    var fileIds = [];
    if (widget.comment.files.length > 0) {
      for (var file in widget.comment.files) fileIds.add(file.id);
      params['files'] = fileIds.join(',');
    }

    if (!isEmpty(widget.comment.id)) {
      params['comment_ID'] = widget.comment.id.toString();
    } else {
      params['comment_post_ID'] = widget.post.id.toString();
    }

    try {
      var res = await wc.commentEdit(params);
      controller.text = '';
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(
          child: AppTextInputField(
              hintText: 'comment'.tr,
              // autoGrow: true,
              maxLines: 5,
              inputAction: TextInputAction.newline,
              controller: controller,
              focusNode: focusNode,
              sufficIcon: Wrap(
                runAlignment: WrapAlignment.end,
                direction: Axis.horizontal,
                children: [
                  FileUploadButton(
                    iconSize: 20,
                    onProgress: (p) {
                      uploadProgress = p;
                      setState(() {});
                    },
                    onUploaded: (file) {
                      widget.comment.files.add(file);
                      uploadProgress = 0;
                      setState(() {});
                    },
                  ),

                  if (loading)
                  Padding(child: CommonSpinner(), padding: EdgeInsets.all(sm)),
                  if (!loading)
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 20,
                      ),
                      onPressed: !isEmpty(controller.text) ? onSubmit : null,
                    ),
                ],
              ),
              onChanged: (value) {
                setState(() {});
              }),
        ),
      ]),
      SizedBox(height: xs),
      if (uploadProgress > 0)
        Padding(
          padding: EdgeInsets.only(top: sm),
          child: LinearProgressIndicator(
            value: uploadProgress,
            backgroundColor: Colors.grey,
          ),
        ),
      FileDisplay(
        widget.comment.files,
        inEdit: true,
        onFileDeleted: (file) {
          widget.comment.deleteFile(file);
          setState(() {});
        },
      ),
      if (!isEmpty(widget.parent) || !isEmpty(widget.comment.id))
        RaisedButton(child: Text('cancel'.tr), onPressed: widget.onCancel)
    ]);
  }
}
