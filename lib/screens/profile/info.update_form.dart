import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:get/get.dart';

class InfoUpdateForm extends StatefulWidget {
  final String title;
  final String value;
  final String paramName;
  final String errorMessage;

  InfoUpdateForm({
    @required this.title,
    @required this.value,
    @required this.paramName,
    @required this.errorMessage,
  });

  @override
  _InfoUpdateFormState createState() => _InfoUpdateFormState();
}

class _InfoUpdateFormState extends State<InfoUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  bool isFormSubmitted = false;
  bool loading = false;

  @override
  void initState() {
    _textController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(lg),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title),
              AppTextInputField(
                controller: _textController,
                autoValidate: isFormSubmitted,
                validator: (str) {
                  if (isEmpty(str)) return widget.errorMessage;
                },
              ),
              SizedBox(height: lg),
              Row(
                children: [
                  if (!loading)
                  FlatButton(
                    color: Color(0xffcb0000),
                    child: Text(
                      'cancel'.tr,
                      style: TextStyle(fontSize: md, color: Color(0xffffffff)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Spacer(),
                  FlatButton(
                    color: Color(0xfff5f5f5),
                    child: !loading
                        ? Text(
                            'submit'.tr,
                            style: TextStyle(
                                fontSize: md, color: Color(0xff1684D0)),
                          )
                        : CommonSpinner(),
                    onPressed: _onFormSubmit,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onFormSubmit() async {
    isFormSubmitted = true;
    setState(() {});

    if (loading) return;
    if (_textController.text.trim() == widget.value) return;

    if (_formKey.currentState.validate()) {
      loading = true;
      setState(() {});

      try {
        await AppService.wc.profileUpdate({
          widget.paramName: _textController.text.trim(),
        });

        loading = false;
        setState(() {});
        Get.back();
      } catch (e) {
        loading = false;
        setState(() {});
        AppService.alertError(e);
      }
    }
  }
}
