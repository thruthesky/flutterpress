import 'package:flutter/material.dart';
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

  static Future<bool> confirmDialog(
    String title,
    Widget content, {
    String textConfirm = 'Yes',
    String textCancel = 'Cancel',
    Function onConfirm,
    Function onCancel,
  }) async {
    return Get.defaultDialog(
      title: title,
      content: content,
      confirmTextColor: Colors.white,
      textConfirm: textConfirm,
      textCancel: textCancel,
      onConfirm: () => true,
      onCancel: () => false,
    );
  }
}
