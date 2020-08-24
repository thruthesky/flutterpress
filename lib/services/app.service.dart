import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppService {
  static final WordpressController wc = Get.find();

  static Future initBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBox.user);
  }

  /// Let the user logs in if he/she has previously logged in.
  // static initUser() {
  //   Box userBox = Hive.box(HiveBox.user);
  //   if (userBox.isNotEmpty) {
  //     var u = userBox.get(BoxKey.currentUser);
  //     print(u);
  //   }
  // }
}
