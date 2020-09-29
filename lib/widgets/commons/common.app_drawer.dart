import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/circular_avatar.dart';
import 'package:flutterpress/widgets/commons/common.icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CommonAppDrawer extends StatefulWidget {
  @override
  _CommonAppDrawerState createState() => _CommonAppDrawerState();
}

class _CommonAppDrawerState extends State<CommonAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<WordpressController>(
        builder: (_) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  children: [
                    Spacer(),
                    CommonIconButton(
                      icon: FontAwesomeIcons.home,
                      iconSize: 26,
                      onTap: () {
                        Get.toNamed(Routes.home);
                      },
                    ),
                    CommonIconButton(
                      icon: FontAwesomeIcons.solidTimesCircle,
                      iconSize: 26,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                if (_.isUserLoggedIn)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircularAvatar(
                          photoURL: _.user.photoURL,
                          height: 40,
                          width: 40,
                          withShadow: true,
                        ),
                        SizedBox(height: lg),
                        Text(
                          _.user.nickName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: xs),
                        Text(
                          'Logged in with ${_.user.socialLogin}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0x99000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                Divider(
                  color: Color(0x1F000000),
                ),
                FlatButton(
                  key: ValueKey(Routes.home),
                  child: Text('home'.tr),
                  onPressed: () => Get.toNamed(Routes.home),
                ),
                if (!_.isUserLoggedIn) ...[
                  FlatButton(
                    key: ValueKey(Routes.login),
                    child: Text('login'.tr),
                    onPressed: () => Get.toNamed(Routes.login),
                  ),
                  FlatButton(
                    key: ValueKey(Routes.register),
                    child: Text('register'.tr),
                    onPressed: () => Get.toNamed(Routes.register),
                  ),
                ],
                if (_.isUserLoggedIn) ...[
                  FlatButton(
                    key: ValueKey(Routes.profile),
                    child: Text('profile'.tr),
                    onPressed: () => Get.toNamed(Routes.profile),
                  ),
                  FlatButton(
                    child: Text('logout'.tr),
                    onPressed: () {
                      _.logout();
                      Get.offAllNamed(Routes.home);
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

