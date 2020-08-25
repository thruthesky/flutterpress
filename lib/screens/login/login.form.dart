import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.service.dart';
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
  final email = TextEditingController(text: 'berry@test.com');
  final pass = TextEditingController(text: 'berry@test.com');
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
      AppService.error('Login Error', e);
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
          TextFormField(
            decoration: InputDecoration(hintText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onEditingComplete: () => passNode.requestFocus(),
            controller: email,
          ),
          TextFormField(
            obscureText: true,
            focusNode: passNode,
            decoration: InputDecoration(hintText: 'Password'),
            onEditingComplete: _onFormSubmit,
            controller: pass,
          ),
          RaisedButton(
            onPressed: _onFormSubmit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
