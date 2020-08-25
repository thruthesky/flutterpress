import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/services/app.routes.dart';
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
                // RaisedButton(
                //   onPressed: () {
                //     Get.updateLocale(Locale('ko'));
                //   },
                //   child: Text('Chnage Locale'),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
