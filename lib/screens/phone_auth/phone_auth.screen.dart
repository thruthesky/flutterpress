import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutterbase_v2/widgets/social_login/phone_auth.form.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
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
                PhoneAuthForm(
                  onVerified: (phoneNo) async {
                    try {
                      await wc.profileUpdate({'mobile': phoneNo});
                      Get.offAllNamed(Routes.profile);
                    } catch (e) {
                      AppService.alertError(e);
                    }
                  },
                  onError: (e) {
                    AppService.alertError(e);
                  },
                ),
                SizedBox(height: md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
