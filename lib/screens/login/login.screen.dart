import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:get/get.dart';
import 'package:flutterpress/screens/login/login.form.dart';
import 'package:flutterpress/widgets/app.drawer.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.loginScaffold),
      appBar: AppBar(
        title: Text('login'.tr),
      ),
      endDrawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: LoginForm(),
      ),
    );
  }
}
