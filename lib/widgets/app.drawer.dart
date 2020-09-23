import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<WordpressController>(
        builder: (_) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    if (_.isUserLoggedIn) ...[
                      Text(_.user.nickName),
                      Text('Logged in with ${_.user.socialLogin}'),
                    ]
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
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
          );
        },
      ),
    );
  }
}
