import 'package:flutter/material.dart';
import 'package:flutterpress/screens/post_list/post_view.dart';
import 'package:flutterpress/widgets/commons/common.app_bar.dart';
import 'package:flutterpress/widgets/commons/common.app_drawer.dart';

class PostViewScreen extends StatefulWidget {
  @override
  _PostViewScreenState createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommonAppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                PostView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
