import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/phone_auth/phone_auth.form.dart';
import 'package:flutterpress/widgets/custom_page_header.dart';
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
                CustomPageHeader(
                  showBackButton: false,
                  title: 'verification'.tr,
                  subtitle: 'phoneAuthVerificationSubtitle'.tr,
                  subtitleSize: md,
                  description: 'phoneAuthVerificationDescription'.tr,
                  descriptionSize: sm,
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
