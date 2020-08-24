import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/screens/profile/profile.update_form.dart';
import 'package:flutterpress/services/app.service.dart';
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('User ID: ${wc.user.id}'),
            Text('User Email: ${wc.user.userEmail}'),
            Divider(),
            ProfileUpdateForm(),
            Divider(),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                wc.logout();
                Get.back();
              },
            ),
            RaisedButton(
              child: Text('Resign'),
              onPressed: () async {
                bool conf = await AppService.confirmDialog(
                  'Resign',
                  Text('Are you sure you want to resign?'),
                );
                if (!conf) return;
                try {
                  await wc.resign();
                } catch (e) {
                  // TODO
                  // AppService.error(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
