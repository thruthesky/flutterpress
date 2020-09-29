import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:flutterpress/widgets/file_display.dart';
import 'package:flutterpress/widgets/file_upload_button.dart';
import 'package:get/get.dart';

class PostEditForm extends StatefulWidget {
  final PostModel post;
  final String slug;

  PostEditForm({
    post,
    this.slug,
  }) : this.post = post != null ? post : PostModel();

  @override
  _PostEditFormState createState() => _PostEditFormState();
}

class _PostEditFormState extends State<PostEditForm> {
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final content = TextEditingController();

  bool isUpdate = false;

  double progress = 0;

  bool loading = false;

  @override
  void initState() {
    if (widget.post.id != null) {
      isUpdate = true;
      title.text = widget.post.title;
      content.text = widget.post.content;
    }
    super.initState();
  }

  void onSubmit() async {
    if (loading) return;
    setState(() {
      loading = true;
      isFormSubmitted = true;
    });

    if (!_formKey.currentState.validate()) {
      loading = false;
      setState(() {});
    } else {
      var params = {
        'slug': widget.slug ?? '',
        'post_title': title.text,
        'post_content': content.text,
      };

      var fileIds = [];
      if (widget.post.files.length > 0) {
        for (var file in widget.post.files) fileIds.add(file.id);
        params['files'] = fileIds.join(',');
      }

      try {
        if (isUpdate) params['ID'] = widget.post.id.toString();
        var res = await wc.postEdit(params, isUpdate: isUpdate);
        res.isInView = true;
        Get.back(result: res);
      } catch (e) {
        AppService.error('$e'.tr);
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(md),
      child: Container(
        padding: EdgeInsets.all(md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTextInputField(
                key: ValueKey(Keys.postTitleInput),
                hintText: 'title'.tr,
                controller: title,
                inputAction: TextInputAction.done,
                validator: (str) {
                  if (isEmpty(str)) return 'errTitleEmpty'.tr;
                },
                autoValidate: isFormSubmitted,
                contentPadding: EdgeInsets.all(sm),
              ),
              SizedBox(height: md),
              AppTextInputField(
                key: ValueKey(Keys.postContentInput),
                hintText: 'content'.tr,
                controller: content,
                inputType: TextInputType.multiline,
                inputAction: TextInputAction.newline,
                minLines: 5,
                maxLines: 15,
                withBorder: true,
                contentPadding: EdgeInsets.all(sm),
              ),

              /// file display
              if (widget.post.files.length > 0) ...[
                SizedBox(height: lg),
                Text('Attached images:'),
                FileDisplay(widget.post.files, inEdit: true,
                    onFileDeleted: (file) {
                  widget.post.deleteFile(file);
                  setState(() {});
                }),
              ],

              /// buttons
              SizedBox(height: lg),
              Row(
                children: [
                  FileUploadButton(
                    onProgress: (value) {
                      progress = value;
                      setState(() {});
                    },
                    onUploaded: (file) {
                      widget.post.files.add(file);
                      progress = 0;
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: sm),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor:
                            progress > 0 ? Colors.grey : Colors.transparent,
                      ),
                    ),
                  ),
                  RaisedButton(
                    key: ValueKey(Keys.formSubmitButton),
                    onPressed: onSubmit,
                    child: !loading
                        ? Text('submit'.tr)
                        : CommonSpinner(isCentered: true),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
