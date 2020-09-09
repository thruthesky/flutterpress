import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/flutterbase_v2/widgets/login_social_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginSocialButtons extends StatelessWidget {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();


  register(options) async {
        await wc.loginOrRegister({
          'user_email': email.text,
          'user_pass': pass.text,
          'nickname': nickname.text,
        });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LoginSocialIcon(
          child: Image.asset(
            'assets/images/kakaotalk.png',
            width: 36,
          ),
          text: '카카오톡',
          onTap: () async {
            try {
              await auth.loginWithKakaotalkAccount();
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),
        LoginSocialIcon(
          child: FaIcon(
            FontAwesomeIcons.facebook,
            size: 36,
            color: Colors.blue[900],
          ),
          text: '페이스북',
          onTap: () async {
            try {
              await auth.loginWithFacebookAccount(context: context);
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),
        LoginSocialIcon(
          child: FaIcon(
            FontAwesomeIcons.googlePlusG,
            size: 36,
            color: Colors.red[900],
          ),
          text: '구글',
          onTap: () async {
            try {
              await auth.loginWithGoogleAccount();
              register({
                'email': 'uid@google.com',
                'password': wc.password('uid')
              });
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),
        FutureBuilder<Object>(
          future: auth.appleSignInAvailable,
          builder: (context, snapshot) {
            // print('snapshot: ${snapshot.data}');
            if (snapshot.data == true) {
              return LoginSocialIcon(
                child: FaIcon(
                  FontAwesomeIcons.apple,
                  size: 36,
                  color: Colors.grey[700],
                ),
                text: '애플',
                onTap: () async {
                  try {
                    User user = await auth.loginWithAppleAccount();
                    print('apple login success: ${user.uid}');
                  } catch (e) {
                    Get.snackbar('loginError'.tr, e.toString());
                  }
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
