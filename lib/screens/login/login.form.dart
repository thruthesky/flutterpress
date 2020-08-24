import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'email'),
            controller: email,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'password'),
            controller: pass,
          ),
          RaisedButton(
            onPressed: () async {
              try {
                await wc.login({
                  'user_email': email.value.text,
                  'user_pass': pass.value.text,
                });
              } catch (e) {
                // TODO
                // AppService.error(e);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
