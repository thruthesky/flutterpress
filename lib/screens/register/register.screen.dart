import 'package:flutter/material.dart';
import 'package:flutterpress/screens/register/register.form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: RegisterForm(),
      ),
    );
  }
}
