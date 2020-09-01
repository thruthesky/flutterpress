import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
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

  bool isFormSubmitted = false;

  /// This function is moved here so it can be reference
  /// by both the submit button and the password textfield.
  ///
  _onFormSubmit() async {
    isFormSubmitted = true;
    setState(() {});
    if (_formKey.currentState.validate()) {
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
            key: ValueKey(AppKeys.emailInput),
            hintText: 'email'.tr,
            controller: email,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            onEditingComplete: passNode.requestFocus,
            autoValidate: isFormSubmitted,
            validator: (email) => AppService.isValidEmail(email),
          ),
          AppTextInputField(
              key: ValueKey(AppKeys.passwordInput),
              hintText: 'password'.tr,
              controller: pass,
              inputAction: TextInputAction.done,
              obscureText: true,
              focusNode: passNode,
              autoValidate: isFormSubmitted,
              validator: (pass) => AppService.isValidPassword(pass),
              onEditingComplete: _onFormSubmit),
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
