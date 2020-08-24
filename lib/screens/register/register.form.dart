import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.routes.dart';
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
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  _onSubmit(String email, String password) {
    wc.register(userEmail: email, userPass: password).then((user) {
      Get.offNamed(AppRoutes.profile);
    }).catchError((err) {
      Get.snackbar(
        'Register Failed',
        '$err',
      );
    });
  }

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
            onPressed: () => _onSubmit(
              emailInputController.value.text,
              passwordInputController.value.text,
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
