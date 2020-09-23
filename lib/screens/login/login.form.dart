import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/widgets/app.text_input_field.dart';
import 'package:flutterpress/widgets/commons/common.button.dart';
import 'package:flutterpress/widgets/commons/common.spinner.dart';
import 'package:flutterpress/widgets/social_login_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
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
        UserModel user = await wc.login({
          'user_email': email.value.text,
          'user_pass': pass.value.text,
        });
        AppService.onUserLogin(user);
      } catch (e) {
        loading = false;
        setState(() {});
        AppService.error('$e'.tr);
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
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
            sufficIcon: Icon(FontAwesomeIcons.userAlt, size: 20),
          ),
          SizedBox(height: lg),
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
                size: 20,
              ),
              onPressed: () {
                hidePassword = !hidePassword;
                setState(() {});
              },
            ),
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
                  'login'.tr.toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.blue[400],
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: lg),
            Row(
              children: [
                CommonButton(
                  child: Text('forgotPassword'.tr),
                  padding: EdgeInsets.all(0),
                  onTap: () {
                    print('TODO: forgot password');
                  },
                ),
                Spacer(),
                CommonButton(
                  child: Text('register'.tr),
                  padding: EdgeInsets.all(0),
                  onTap: () {
                    Get.toNamed(Routes.register);
                  },
                ),
              ],
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
