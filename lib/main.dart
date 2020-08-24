import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/screens/home/home.screen.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(FlutterPress());
}

class FlutterPress extends StatefulWidget {
  @override
  _FlutterPressState createState() => _FlutterPressState();
}

class _FlutterPressState extends State<FlutterPress> {
  final WordpressController wc = Get.put(WordpressController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Press',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.home,
        getPages: [
          GetPage(name: AppRoutes.home, page: () => HomeScreen()),
        ]);
  }
}
