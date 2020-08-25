import 'package:flutter/material.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/widgets/app_drawer.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr),
      ),
      endDrawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RegisterForm(),
      ),
    );
  }
}
