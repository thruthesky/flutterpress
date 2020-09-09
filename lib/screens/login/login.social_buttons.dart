import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/flutterbase_v2/widgets/login_social_icon.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginSocialButtons extends StatelessWidget {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  loginOrRegister({String email, String password, String name}) async {
    UserModel u = await wc.loginOrRegister({
      'user_email': email,
      'user_pass': password,
      'nickname': name,
    });

    if (!isEmpty(u)) {
      Get.offAllNamed(Routes.home);
    }
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
              User user = await auth.loginWithKakaotalkAccount();
              await loginOrRegister(
                email: '${user.uid}@kakao.com',
                password: wc.password('${user.uid}'),
                name: user.displayName,
              );
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
              User user = await auth.loginWithFacebookAccount(context: context);
              await loginOrRegister(
                email: '${user.uid}@facebook.com',
                password: wc.password('${user.uid}'),
                name: user.displayName,
              );
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
              User user = await auth.loginWithGoogleAccount();
              await loginOrRegister(
                email: '${user.uid}@gmail.com',
                password: wc.password('${user.uid}'),
                name: user.displayName,
              );
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
                    // print('apple login success: ${user.uid}');
                    await loginOrRegister(
                      email: '${user.uid}@apple.com',
                      password: wc.password('${user.uid}'),
                      name: user.displayName,
                    );
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
