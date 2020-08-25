import 'package:flutter/material.dart';
import 'package:flutterpress/screens/register/register.form.dart';
import 'package:flutterpress/widgets/app_drawer.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      endDrawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RegisterForm(),
      ),
    );
  }
}
