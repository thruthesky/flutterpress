import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final WordpressController wc = Get.find();

  _onLogoutButtonTap() {
    wc.logout();
    Get.back();
  }

  _onResignButtonTap() async {
    Get.defaultDialog(
      title: 'Resign',
      content: Column(
        children: [
          Text(
            'Resigning your account will permanently remove your information',
          ),
          Text('Are you sure you want to resign?'),
        ],
      ),
      confirmTextColor: Colors.white,
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () {
        Get.back();
        wc.resign().then((value) {
          print(value);
          Get.back();
        }).catchError((err) {
          Get.snackbar('Resign Error', '$err');
        }).whenComplete(() => Get.back);
      },
      onCancel: () => Get.back,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('User ID: ${wc.user.id}'),
            Text('User Email: ${wc.user.userEmail}'),
            Text('User firstname: ${wc.user.firstName}'),
            Text('User lastname: ${wc.user.lastName}'),
            Text('User photo URL: ${wc.user.photoURL}'),
            Text('User session ID: ${wc.user.sessionId}'),
            Divider(),
            RaisedButton(
              child: Text('Logout'),
              onPressed: _onLogoutButtonTap,
            ),
            RaisedButton(
              child: Text('Resign'),
              onPressed: _onResignButtonTap,
            ),
          ],
        ),
      ),
    );
  }
}
