import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final WordpressController wc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Container(
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
              onPressed: () {
                wc.logout();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
