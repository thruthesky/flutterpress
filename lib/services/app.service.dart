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

  ///
  ///
  static Future<bool> confirmDialog(
    String title,
    Widget content, {
    String textConfirm,
    String textCancel,
    Function onConfirm,
    Function onCancel,
  }) async {
    return await Get.defaultDialog(
          title: title,
          content: content,
          confirmTextColor: Colors.white,
          textConfirm: textConfirm ?? 'yes'.tr,
          textCancel: textCancel ?? 'cancel'.tr,
          onConfirm: () => true,
          onCancel: () => false,
        ) ??
        false;
  }

  ///
  ///
  static openSnackbar(
    String title,
    String message, {
    Color bgColor,
    Color textColor,
    Duration duration = const Duration(seconds: 2),
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: bgColor,
      colorText: textColor,
      duration: duration,
      snackPosition: position,
    );
  }

  ///
  ///
  static error(String title, String message) {
    openSnackbar(
      title,
      message,
      bgColor: Colors.red[400],
      textColor: Colors.white,
    );
  }
}
