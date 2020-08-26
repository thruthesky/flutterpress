import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

/// TODO
///   - Add validation
///   - Update UI
class RegisterFormState extends State<RegisterForm> {
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final nickname = TextEditingController();

  final passNode = FocusNode();
  final nicknameNode = FocusNode();

  /// This function is moved here so it can be reference
  /// by both the submit button and the password textfield.
  ///
  _onFormSubmit() async {
    try {
      await wc.register({
        'user_email': email.text,
        'user_pass': pass.text,
        'nickname': nickname.text,
      });
      Get.back();
    } catch (e) {
      AppService.error('$e'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          AppTextInputField(
            key: ValueKey(AppKeys.emailInput),
            hintText: 'email'.tr,
            controller: email,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            onEditingComplete: passNode.requestFocus,
          ),
          AppTextInputField(
            key: ValueKey(AppKeys.passwordInput),
            hintText: 'password'.tr,
            controller: pass,
            inputAction: TextInputAction.next,
            obscureText: true,
            onEditingComplete: nicknameNode.requestFocus,
            focusNode: passNode,
          ),
          AppTextInputField(
            key: ValueKey(AppKeys.nicknameInput),
            hintText: 'nickname'.tr,
            controller: nickname,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            onEditingComplete: _onFormSubmit,
            focusNode: nicknameNode,
          ),
          RaisedButton(
            key: ValueKey(AppKeys.formSubmitButton),
            onPressed: _onFormSubmit,
            child: Text('submit'.tr),
          ),
        ],
      ),
    );
  }
}
