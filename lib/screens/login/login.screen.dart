import 'package:flutter/material.dart';
import 'package:flutterpress/screens/login/login.form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: LoginForm(),
      ),
    );
  }
}
