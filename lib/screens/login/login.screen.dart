import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/screens/login/login.form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.loginScaffold),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.chevronLeft),
                      SizedBox(width: lg),
                      Text('Back', style: TextStyle(fontSize: md)),
                    ],
                  ),
                  onPressed: () => Get.back(),
                ),
                SizedBox(height: 100),
                Text('Proceed with your', style: TextStyle(fontSize: lg)),
                Text(
                  'login'.tr,
                  style: TextStyle(fontSize: xl, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: xl),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
