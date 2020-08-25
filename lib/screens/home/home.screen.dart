import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/widgets/app_drawer.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('HomePage'),
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
                    child: Text('Login'),
                    onPressed: () => Get.toNamed(AppRoutes.login),
                  ),
                if (!wc.isUserLoggedIn)
                  RaisedButton(
                    child: Text('Register'),
                    onPressed: () => Get.toNamed(AppRoutes.register),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    child: Text('Profile'),
                    onPressed: () => Get.toNamed(AppRoutes.profile),
                  ),
                if (wc.isUserLoggedIn)
                  RaisedButton(
                    child: Text('Logout'),
                    onPressed: () => wc.logout(),
                  ),
                RaisedButton(
                  onPressed: () {
                    Get.updateLocale(Locale('ko'));
                  },
                  child: Text('Chnage Locale'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
