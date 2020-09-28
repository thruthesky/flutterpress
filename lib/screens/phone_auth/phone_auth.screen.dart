import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/phone_auth/phone_auth.form.dart';
import 'package:flutterpress/widgets/commons/common.page_header.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonPageHeader(
                  showBackButton: false,
                  title: 'verification'.tr,
                  subtitle: 'phoneAuthVerificationSubtitle'.tr,
                  description: 'phoneAuthVerificationDescription'.tr,
                ),
                SizedBox(height: xxl),
                PhoneAuthForm(),
                SizedBox(height: md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
