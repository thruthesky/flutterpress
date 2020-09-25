import 'package:flutter/material.dart';
import 'package:flutterpress/screens/post_edit/post_edit.form.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';

class PostEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Keys.postEditScreenScaffold),
      appBar: AppBar(),
      endDrawer: CommonAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(child: PostEditForm()),
      ),
    );
  }
}
