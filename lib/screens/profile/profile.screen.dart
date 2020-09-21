import 'package:flutter/material.dart';
import 'package:flutterpress/screens/profile/profile.update_form.dart';
import 'package:flutterpress/screens/profile/profile_info.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.profileScaffold),
      appBar: AppBar(
        title: Text('profile'.tr),
        automaticallyImplyLeading: false,
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ProfileInfo(),
              Divider(),
              ProfileUpdateForm(),
            ],
          ),
        ),
      ),
    );
  }
}
