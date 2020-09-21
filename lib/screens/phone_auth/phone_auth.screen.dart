import 'package:flutter/material.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutterbase_v2/widgets/social_login/phone_auth.form.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:get/get.dart';

class PhoneAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(lg),
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  'Phone number verification',
                  style: TextStyle(fontSize: lg),
                ),
                SizedBox(height: xxl),
                PhoneAuthForm(
                  onVerified: (phoneNo) {
                    Get.offAllNamed(Routes.profile);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
