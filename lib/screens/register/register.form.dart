import 'package:flutter/material.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

bool isFormSubmitted = false;
bool hidePassword = true;
bool loading = false;

/// TODO
///   - Update UI
class RegisterFormState extends State<RegisterForm> {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final nickname = TextEditingController();
  final mobile = TextEditingController();

  final passNode = FocusNode();
  final nicknameNode = FocusNode();
  final mobileNode = FocusNode();

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
        var res = await auth.register({
          'email': email.text,
          'password': pass.text,
          'displayName': nickname.text,
        });
        print(res);
        await wc.register({
          'user_email': email.text,
          'user_pass': pass.text,
          'nickname': nickname.text,
          'mobile': mobile.text,
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
          AppTextInputField(
            key: ValueKey(Keys.passwordInput),
            labelText: 'password'.tr,
            controller: pass,
            inputAction: TextInputAction.next,
            obscureText: hidePassword,
            onEditingComplete: nicknameNode.requestFocus,
            focusNode: passNode,
            autoValidate: isFormSubmitted,
            validator: (pass) => AppService.isValidPassword(pass),
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
          AppTextInputField(
            key: ValueKey(Keys.nicknameInput),
            labelText: 'nickname'.tr,
            controller: nickname,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            onEditingComplete: _onFormSubmit,
            focusNode: nicknameNode,
            autoValidate: isFormSubmitted,
            validator: (nickname) {
              if (isEmpty(nickname)) return 'nickname_empty'.tr;
            },
          ),
          AppTextInputField(
            key: ValueKey(Keys.mobileInput),
            labelText: 'mobileNo'.tr,
            controller: mobile,
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            onEditingComplete: _onFormSubmit,
            focusNode: mobileNode,
            autoValidate: isFormSubmitted,
            validator: (mobile) {
              if (isEmpty(mobile)) return 'Mobile number is empty'.tr;
            },
          ),
          RaisedButton(
            key: ValueKey(Keys.formSubmitButton),
            onPressed: _onFormSubmit,
            child: Text('submit'.tr),
          ),
        ],
      ),
    );
  }
}
