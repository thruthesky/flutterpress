import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/screens/login/login.form.dart';
import 'package:flutterpress/widgets/custom_page_header.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.loginScaffold),
      appBar: AppBar(
        title: Text('login'.tr),
        centerTitle: false,
      ),
      endDrawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPageHeader(
                  title: 'login'.tr,
                  subtitle: 'Proceed with your',
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
