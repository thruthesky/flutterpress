import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/screens/login/login.form.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.page_header.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.loginScaffold),
      appBar: CommonAppBar(
        title: Text('login'.tr),
      ),
      endDrawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonPageHeader(
                  title: 'login'.tr,
                  subtitle: 'Proceed with your',
                  subtitleSize: 20,
                  subtitleSpacing: -0.5,
                  subtitleWeight: FontWeight.w500,
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
