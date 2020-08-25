import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app_text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

/// TODO
///   - Add validation
///   - Update UI
class LoginFormState extends State<LoginForm> {
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final passNode = FocusNode();

  /// This function is moved here so it can be reference
  /// by both the submit button and the password textfield.
  ///
  _onFormSubmit() async {
    try {
      await wc.login({
        'user_email': email.value.text,
        'user_pass': pass.value.text,
      });
      Get.back();
    } catch (e) {
      AppService.error('$e'.tr);
    }
  }

  @override
  void dispose() {
    passNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextInputField(
            hintText: 'email'.tr,
            controller: email,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            onEditingComplete: passNode.requestFocus,
          ),
          AppTextInputField(
            hintText: 'password'.tr,
            controller: pass,
            inputAction: TextInputAction.done,
            obscureText: true,
            focusNode: passNode,
          ),
          RaisedButton(
            onPressed: _onFormSubmit,
            child: Text('submit'.tr),
          ),
        ],
      ),
    );
  }
}
