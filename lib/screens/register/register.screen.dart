import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/login.social_buttons.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/custom_page_header.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.registerScaffold),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPageHeader(
                  title: 'register'.tr,
                  subtitle: 'Fill in the form',
                ),
                SizedBox(height: xl),
                RegisterForm(),
                SizedBox(height: lg),
                Center(child: Text('Login with')),
                SizedBox(height: md),
                LoginSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
