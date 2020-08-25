import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/screens/home/home.screen.dart';
import 'package:flutterpress/screens/login/login.screen.dart';
import 'package:flutterpress/screens/profile/profile.screen.dart';
import 'package:flutterpress/screens/register/register.screen.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/app.translations.dart';
import 'package:get/get.dart';

void main() async {
  await AppService.initBoxes();
  runApp(FlutterPress());
}

class FlutterPress extends StatefulWidget {
  @override
  _FlutterPressState createState() => _FlutterPressState();
}

class _FlutterPressState extends State<FlutterPress> {
  final WordpressController wc = Get.put(WordpressController());

  @override
  void initState() {
    super.initState();

    () async {
      // Get.updateLocale(Locale('ko'));
      // try {} catch (e) {
      //   print('Caught error: $e');
      // }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Press',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: Locale('ko'),
      translations: AppTranslations(),
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(name: AppRoutes.home, page: () => HomeScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
        GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
      ],
    );
  }
}
