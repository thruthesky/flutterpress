import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/screens/phone_auth/phone_auth.code_form.dart';
import 'package:flutterpress/widgets/commons/common.page_header.dart';
import 'package:get/get.dart';

class PhoneAuthCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = Get.arguments;
    String mobileNo = args['mobileNo'];
    String sessionID = args['sessionID'];

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
                  title: 'Verify',
                  subtitle: 'Input Verification Code',
                  description: 'Verification code sent to $mobileNo',
                ),
                SizedBox(height: xxl),
                PhoneAuthCodeForm(mobileNo: mobileNo, sessionID: sessionID),
                SizedBox(height: md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
