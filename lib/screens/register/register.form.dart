import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:flutterpress/widgets/social_login_buttons.dart';
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

class RegisterFormState extends State<RegisterForm> {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
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
    /**
     * remove any input focus.
     */
    FocusScope.of(context).requestFocus(new FocusNode());

    isFormSubmitted = true;
    setState(() {});
    if (_formKey.currentState.validate()) {
      loading = true;
      setState(() {});

      try {
        UserModel user = await wc.register({
          'user_email': email.text,
          'user_pass': pass.text,
          'nickname': nickname.text,
        });
        await auth.loginWithToken(user.firebaseToken);
        AppService.onUserLogin(user);
      } catch (e) {
        loading = false;
        setState(() {});
        AppService.error('$e'.tr);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    nickname.dispose();
    passNode.dispose();
    nicknameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: xl),
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
          SizedBox(height: xl),
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
          SizedBox(height: loading ? xxl : xl),
          if (loading) Center(child: CommonSpinner()),
          if (!loading) ...[
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(sm),
                key: ValueKey(Keys.formSubmitButton),
                onPressed: _onFormSubmit,
                child: Text(
                  'register'.tr.toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.blue[400],
                textColor: Colors.white,
              ),
            ),

            /// social buttons
            SizedBox(height: xl),
            LoginSocialButtons(
              onSuccess: () {
                loading = true;
                setState(() {});
              },
              onFail: () {
                loading = false;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }
}
