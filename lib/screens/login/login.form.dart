import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.routes.dart';
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
  final emailInputController = TextEditingController(text: 'berry@test.com');
  final passwordInputController = TextEditingController(text: 'berry@test.com');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: 'email'),
            controller: emailInputController,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'password'),
            controller: passwordInputController,
          ),
          RaisedButton(
            onPressed: () async {
              /// @TODO: from here.
              await wc.login(
                userEmail: emailInputController.value.text,
                userPass: passwordInputController.value.text,
              );

              //     .then((user) {
              //   Get.offNamed(AppRoutes.profile);
              // }).catchError((err) {
              //   Get.snackbar(
              //     'Login Failed',
              //     '$err',
              //   );
              // });
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
