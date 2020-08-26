import 'package:flutter/material.dart';
import 'package:flutterpress/screens/post_edit/post_edit.form.dart';
import 'package:flutterpress/widgets/app.drawer.dart';

class PostEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: AppDrawer(),
      body: PostEditForm(),
    );
  }
}
