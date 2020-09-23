import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.auth.service.dart';
import 'package:flutterpress/widgets/icon_text_button.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/or_divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginSocialButtons extends StatelessWidget {
  final FlutterbaseAuthService auth = FlutterbaseAuthService();
  final WordpressController wc = Get.find();

  final Function onSuccess;
  final Function onFail;

  LoginSocialButtons({this.onSuccess, this.onFail});

  Future socialLogin(User firebaseUser) async {
    if (onSuccess != null) onSuccess();
    UserModel user = await wc.socialLogin(firebaseUser);
    AppService.onUserLogin(user);
  }

  onError(e) {  
    if (onFail != null) onFail();
    AppService.alertError('loginError'.tr, e);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrDivider(),
        SizedBox(height: lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// [KakaoTalk Sign-in]
            IconTextButton(
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
                  onError(e);
                }
              },
            ),

            /// [Facebook Sign-in]
            IconTextButton(
              child: FaIcon(
                FontAwesomeIcons.facebook,
                size: 36,
                color: Colors.blue[900],
              ),
              text: '페이스북',
              onTap: () async {
                try {
                  User user =
                      await auth.loginWithFacebookAccount(context: context);
                  await socialLogin(user);
                  Get.toNamed(Routes.phoneAuth);
                } catch (e) {
                  onError(e);
                }
              },
            ),

            /// [Google Sign-in]
            IconTextButton(
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
                } catch (e) {
                  onError(e);
                }
              },
            ),

            /// [Apple Sign-in]
            FutureBuilder<Object>(
              future: auth.appleSignInAvailable,
              builder: (context, snapshot) {
                // print('snapshot: ${snapshot.data}');
                if (snapshot.data == true) {
                  return IconTextButton(
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
                        onError(e);
                      }
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
