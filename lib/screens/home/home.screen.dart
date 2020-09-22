import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WordpressController wc = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.homeScaffold),
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
                      key: ValueKey(Routes.postList),
                      child: Text('postList'.tr),
                      onPressed: () => Get.toNamed(
                        Routes.postList,
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
                    key: ValueKey(Routes.login),
                    child: Text('login'.tr),
                    onPressed: () => Get.toNamed(Routes.login),
                  ),
                if (!wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(Routes.register),
                    child: Text('register'.tr),
                    onPressed: () => Get.toNamed(Routes.register),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(Routes.profile),
                    child: Text('profile'.tr),
                    onPressed: () => Get.toNamed(Routes.profile),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    key: ValueKey(Keys.logoutButton),
                    child: Text('logout'.tr),
                    onPressed: () => wc.logout(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
