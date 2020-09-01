import 'package:flutter/material.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:flutterpress/screens/login/login.form.dart';
import 'package:flutterpress/widgets/app.drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(AppKeys.loginScaffold),
      endDrawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.chevronLeft),
                    SizedBox(width: 20),
                    Text('Back', style: TextStyle(fontSize: 18)),
                  ],
                ),
                onTap: () => Get.back(),
              ),
              SizedBox(height: 100),
              Text(
                'Proceed with your',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'login'.tr,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
