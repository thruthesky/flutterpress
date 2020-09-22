import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/phone_auth/phone_auth.form.dart';
import 'package:flutterpress/widgets/custom_page_header.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPageHeader(
                  showBackButton: false,
                  title: 'verification'.tr,
                  subtitle: 'phoneAuthVerificationSubtitle'.tr,
                  subtitleSize: md,
                  description: 'phoneAuthVerificationDescription'.tr,
                ),
                SizedBox(height: xl),
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
