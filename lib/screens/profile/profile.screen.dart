import 'package:flutter/material.dart';
import 'package:flutterpress/screens/profile/profile_info.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.profileScaffold),
      appBar: AppBar(
        title: Text('profile'.tr),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ProfileInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
