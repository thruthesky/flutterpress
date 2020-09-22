import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/flutterbase_v2/widgets/social_login/login_social_icon.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginSocialButtons extends StatelessWidget {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  Future socialLogin(User firebaseUser) async {
    final String uid = firebaseUser.uid;
    final String provider = firebaseUser.providerData[0].providerId;

    UserModel user = await wc.socialLogin(
      firebaseUID: uid,
      email: firebaseUser.email,
      provider: provider,
    );

    if (user.hasMobile) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.toNamed(Routes.phoneAuth);
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
              User firebaseUser = await auth.loginWithKakaotalkAccount();
              await socialLogin(firebaseUser);
            } catch (e) {
              AppService.alertError('loginError'.tr, e);
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
              await socialLogin(user);
              Get.toNamed(Routes.phoneAuth);
            } catch (e) {
              print(e);
              AppService.alertError('loginError'.tr, e);
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
              await socialLogin(user);
              Get.toNamed(Routes.phoneAuth);
            } catch (e) {
              AppService.alertError('loginError'.tr, e);
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
                    await socialLogin(user);
                  } catch (e) {
                    AppService.alertError('loginError'.tr, e);
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
