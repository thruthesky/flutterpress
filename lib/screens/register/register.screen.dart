import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.page_header.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.registerScaffold),
      appBar: CommonAppBar(
        title: Text('register'.tr),
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
                  title: 'register'.tr,
                  subtitle: 'Fill in the form',
                ),
                SizedBox(height: xl),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
