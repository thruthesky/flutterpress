import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WordpressController wc = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var obj = {
      'nickname': 'ShouldBeDisplayName',
      'first_name': '',
      'last_name': '',
      'user_email': 'cherry@test.com',
      'anyvalue': 'canBePut',
      'route': 'user.register',
      'ID': 4,
      'user_login': 'cherry@test.com',
      'user_registered': '2020-08-24 06:31:19',
      'session_id': '4_54801d0079d61d7199850b5df7289bea',
      'photoURL': ''
    };

    UserModel u = UserModel.fromJson(obj);

    print(u);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Text('Body'),
    );
  }
}
