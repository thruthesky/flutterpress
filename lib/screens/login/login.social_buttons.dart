import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/flutterbase_v2/widgets/social_login/phone_login_dialog.dart';
import 'package:flutterpress/flutterbase_v2/widgets/social_login/login_social_icon.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginSocialButtons extends StatelessWidget {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  Future<void> loginOrRegister({User user, String provider}) async {
    final email = '${user.uid}@$provider.com';
    final password = wc.password('${user.uid}');
    final name = user.displayName;

    UserModel u;
    try {
      u = await wc.loginOrRegister({
        'user_email': email,
        'user_pass': password,
        'nickname': name,
      });
    } catch (e) {
      AppService.error(e);
    }

    print('user');
    print(u.toString());
    if (!isEmpty(u)) {
      print('Redirect to home after loginOrRegister() complete');
      Get.offAllNamed(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// [KakaoTalk Sign-in]
        LoginSocialIcon(
          child: Image.asset(
            'assets/images/kakaotalk.png',
            width: 36,
          ),
          text: '카카오톡',
          onTap: () async {
            try {
              User user = await auth.loginWithKakaotalkAccount();
              await loginOrRegister(user: user, provider: 'kakaotalk');
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),

        /// [Facebook Sign-in]
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
              await loginOrRegister(user: user, provider: 'facebook');
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),

        /// [Google Sign-in]
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
              await loginOrRegister(user: user, provider: 'google');
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),

        /// [Apple Sign-in]
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
                    await loginOrRegister(user: user, provider: 'apple');
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

        /// [PhoneNumber Sign-in]
        LoginSocialIcon(
          child: FaIcon(
            FontAwesomeIcons.phoneSquare,
            size: 36,
            color: Colors.grey[700],
          ),
          text: 'Phone',
          onTap: () async {
            User user = await Get.dialog(
              PhoneLoginDialog(),
              barrierDismissible: false,
            );
            if (user == null) return;

            // print('Verification complete');
            // print(user);
            try {
              await loginOrRegister(user: user, provider: 'phone');
            } catch (e) {
              Get.snackbar('loginError'.tr, e.toString());
            }
          },
        ),
      ],
    );
  }
}
