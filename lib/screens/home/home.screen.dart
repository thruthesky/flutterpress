import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/auth.service.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WordpressController wc = Get.find();
  FlutterbaseAuthService auth = FlutterbaseAuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('User:${wc.user}');

    return Scaffold(
      key: ValueKey(AppKeys.homeScaffold),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home'.tr),
      ),
      endDrawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GetBuilder<WordpressController>(
          builder: (_) {
            return Column(
              children: [
                Text('Is user logged in: ${wc.isUserLoggedIn}'),
                Divider(),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    RaisedButton(
                      key: ValueKey(AppRoutes.postList),
                      child: Text('postList'.tr),
                      onPressed: () => Get.toNamed(
                        AppRoutes.postList,
                        arguments: {},
                      ),
                    ),
                    RaisedButton(
                      key: ValueKey('discuss'),
                      child: Text('Discuss'.tr),
                      onPressed: () => openForum('discuss'),
                    ),
                    RaisedButton(
                      key: ValueKey('qna'),
                      child: Text('QnA'.tr),
                      onPressed: () => openForum('qna'),
                    ),
                    RaisedButton(
                      key: ValueKey('market'),
                      child: Text('Buy&Sell'.tr),
                      onPressed: () => openForum('market'),
                    ),
                  ],
                ),
                Divider(),
                if (!wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(AppRoutes.login),
                    child: Text('login'.tr),
                    onPressed: () => Get.toNamed(AppRoutes.login),
                  ),
                if (!wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(AppRoutes.register),
                    child: Text('register'.tr),
                    onPressed: () => Get.toNamed(AppRoutes.register),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(AppRoutes.profile),
                    child: Text('profile'.tr),
                    onPressed: () => Get.toNamed(AppRoutes.profile),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(AppKeys.logoutButton),
                    child: Text('logout'.tr),
                    onPressed: () => wc.logout(),
                  ),
                RaisedButton(
                  child: Text('login with google'),
                  onPressed: () async {
                    try {
                      await auth.loginWithGoogleAccount();
                    } catch (e) {
                      Get.snackbar('loginError'.tr, e.toString());
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
