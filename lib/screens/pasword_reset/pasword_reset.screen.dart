import 'package:flutter/material.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';

class PasswordResetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.passwordResetScreenScaffold),
      appBar: CommonAppBar(title: Text('Password Reset')),
      endDrawer: CommonAppDrawer(),
      body: Container(
        child: Text('TODO : PASSWORD RESET'),
      ),
    );
  }
}
