import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.routes.dart';
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
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              FlatButton(
                key: ValueKey(AppRoutes.home),
                child: Text('home'.tr),
                onPressed: () => Get.toNamed(AppRoutes.home),
              ),
              if (!_.isUserLoggedIn)
                FlatButton(
                  key: ValueKey(AppRoutes.login),
                  child: Text('login'.tr),
                  onPressed: () => Get.toNamed(AppRoutes.login),
                ),
              if (!_.isUserLoggedIn)
                FlatButton(
                  key: ValueKey(AppRoutes.register),
                  child: Text('register'.tr),
                  onPressed: () => Get.toNamed(AppRoutes.register),
                ),
              if (_.isUserLoggedIn)
                FlatButton(
                  key: ValueKey(AppRoutes.profile),
                  child: Text('profile'.tr),
                  onPressed: () => Get.toNamed(AppRoutes.profile),
                ),
              if (_.isUserLoggedIn)
                FlatButton(
                  child: Text('logout'.tr),
                  onPressed: () => _.logout(),
                ),
            ],
          );
        },
      ),
    );
  }
}
