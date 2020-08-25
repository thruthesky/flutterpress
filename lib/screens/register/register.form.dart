import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.service.dart';
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

  _onFormSubmit() async {
    try {
      await wc.register({
        'user_email': email.text,
        'user_pass': pass.text,
        'nickname': nickname.text,
      });
      Get.back();
    } catch (e) {
      AppService.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'email'.tr),
            onEditingComplete: () => passNode.requestFocus(),
            controller: email,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: 'password'.tr),
            onEditingComplete: () => nicknameNode.requestFocus(),
            controller: pass,
            obscureText: true,
            focusNode: passNode,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(hintText: 'nickname'.tr),
            keyboardType: TextInputType.text,
            controller: nickname,
            focusNode: nicknameNode,
            onEditingComplete: _onFormSubmit,
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
