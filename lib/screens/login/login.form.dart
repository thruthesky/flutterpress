import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

/// TODO
///   - Update UI
class LoginFormState extends State<LoginForm> {
  // final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final passNode = FocusNode();

  bool isFormSubmitted = false;
  bool hidePassword = true;
  bool loading = false;

  /// This function is moved here so it can be reference
  /// by both the submit button and the password textfield.
  ///
  _onFormSubmit() async {
    isFormSubmitted = true;
    setState(() {});
    if (_formKey.currentState.validate()) {
      loading = true;
      setState(() {});
      try {
        await wc.login({
          'user_email': email.value.text,
          'user_pass': pass.value.text,
        });
        Get.offAllNamed(Routes.home);
      } catch (e) {
        loading = false;
        setState(() {});
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
            key: ValueKey(Keys.emailInput),
            labelText: 'email'.tr,
            controller: email,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            onEditingComplete: passNode.requestFocus,
            autoValidate: isFormSubmitted,
            validator: (email) => AppService.isValidEmail(email),
            sufficIcon: Icon(FontAwesomeIcons.userAlt),
          ),
          SizedBox(height: sm),
          AppTextInputField(
            key: ValueKey(Keys.passwordInput),
            labelText: 'password'.tr,
            controller: pass,
            inputAction: TextInputAction.done,
            obscureText: hidePassword,
            focusNode: passNode,
            autoValidate: isFormSubmitted,
            validator: (pass) => AppService.isValidPassword(pass),
            onEditingComplete: _onFormSubmit,
            sufficIcon: IconButton(
              icon: Icon(
                hidePassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              ),
              onPressed: () {
                hidePassword = !hidePassword;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: xl),
          if (loading) Center(child: CircularProgressIndicator()),
          if (!loading)
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                key: ValueKey(Keys.formSubmitButton),
                onPressed: _onFormSubmit,
                child: Text('login'.tr.toUpperCase()),
                color: Colors.blue[600],
                textColor: Colors.white,
              ),
            ),
          SizedBox(height: sm),
          // RaisedButton(
          //   child: Text('login with google'),
          //   onPressed: () async {
          //     try {
          //       await auth.loginWithGoogleAccount();
          //     } catch (e) {
          //       Get.snackbar('loginError'.tr, e.toString());
          //     }
          //   },
          // ),
          SizedBox(height: sm),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              key: ValueKey(Keys.forgotPasswordButton),
              onPressed: () {
                print('TODO: FORGOT PASSWORD');
              },
              child: Text('forgotPassword'.tr),
            ),
          ),
        ],
      ),
    );
  }
}
