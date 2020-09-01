import 'package:flutter/material.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.registerScaffold),
      appBar: AppBar(
        title: Text('register'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RegisterForm(),
      ),
    );
  }
}
