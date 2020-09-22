import 'package:after_layout/after_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/flutter_i18n/locale.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.controller.dart';
import 'package:flutterpress/screens/home/home.screen.dart';
import 'package:flutterpress/screens/login/login.screen.dart';
import 'package:flutterpress/screens/phone_auth/phone_auth.screen.dart';
import 'package:flutterpress/screens/post_edit/post_edit.screen.dart';
import 'package:flutterpress/screens/post_list/post_list.screen.dart';
import 'package:flutterpress/screens/profile/profile.screen.dart';
import 'package:flutterpress/screens/register/register.screen.dart';
import 'package:flutterpress/services/routes.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:flutterpress/services/app.translations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppService.initBoxes();
  runApp(FlutterPress());
}

class FlutterPress extends StatefulWidget {
  @override
  _FlutterPressState createState() => _FlutterPressState();
}

class _FlutterPressState extends State<FlutterPress>
    with AfterLayoutMixin<FlutterPress> {
  final WordpressController wc = Get.put(WordpressController());
  final FlutterbaseController flutterbaseController = Get.put(
    FlutterbaseController(
      facebookAppId: 783671305107698,
      facebookRedirectUrl: 'https://www.facebook.com/connect/login_success.html',
      kakaotalkClientId: '3ac9c1457bb0724adb20a949bffd720e', // Native App Key
      kakaotalkJavascriptClientId: '937af10cf8688bd9a7554cf088b2ac3e', // Javascript App Key
    ),
  );

  @override
  void afterFirstLayout(BuildContext context) async {
    String locale = await I18n.init();
    Get.updateLocale(Locale(locale));
    // Get.updateLocale(Locale('ko'));
  }

  @override
  void initState() {
    super.initState();
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
      initialRoute: Routes.home,
      // initialRoute: Routes.phoneAuth,
      getPages: [
        GetPage(name: Routes.home, page: () => HomeScreen()),
        GetPage(name: Routes.login, page: () => LoginScreen()),
        GetPage(name: Routes.register, page: () => RegisterScreen()),
        GetPage(name: Routes.profile, page: () => ProfileScreen()),
        GetPage(name: Routes.postList, page: () => PostListScreen()),
        GetPage(name: Routes.postEdit, page: () => PostEditScreen()),
        GetPage(name: Routes.phoneAuth, page: () => PhoneAuthScreen()),
      ],
    );
  }
}
