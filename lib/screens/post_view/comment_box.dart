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

  /// Only resctrict submission when:
  ///  1. comment content and files are both empty.
  ///  2. loading is true.
  onSubmit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (isEmpty(controller.text) && isEmpty(widget.comment.files)) {
      AppService.error('Please provide content or image');
      return;
    }

    if (loading) return;

    loading = true;
    setState(() {});

    var params = {
      'comment_content': controller.text.trim(),
      'comment_parent': widget.parent,
    };

    var fileIds = [];
    if (widget.comment.files.length > 0) {
      for (var file in widget.comment.files) fileIds.add(file.id);
      params['files'] = fileIds.join(',');
    }

    if (!isEmpty(widget.comment.id)) {
      /// update
      params['comment_ID'] = widget.comment.id.toString();
    } else {
      /// create
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sm),
        Row(children: [
          Expanded(
            child: AppTextInputField(
              hintText: 'comment'.tr,
              maxLines: 5,
              inputAction: TextInputAction.newline,
              controller: controller,
              focusNode: focusNode,
              withBorder: true,
              contentPadding: EdgeInsets.all(md),
              sufficIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
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
                    Padding(
                      child: CommonSpinner(),
                      padding: EdgeInsets.all(sm),
                    ),
                  if (!loading)
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 20,
                      ),
                      onPressed: onSubmit,
                    ),
                ],
              ),
            ),
          ),
        ]),
        if (uploadProgress > 0) ...[
          SizedBox(height: xs),
          Padding(
            padding: EdgeInsets.only(top: sm),
            child: LinearProgressIndicator(
              value: uploadProgress,
              backgroundColor: Colors.grey,
            ),
          ),
        ],
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
      ],
    );
  }
}
