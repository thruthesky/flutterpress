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
  static confirmDialog(
    String title,
    Widget content, {
    String textConfirm,
    String textCancel,
    Function onConfirm,
    Function onCancel,
  }) async {
    await Get.defaultDialog(
      title: title,
      content: content,
      confirmTextColor: Colors.white,
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
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

  /// shows error using snackbar
  ///
  /// `title` and `message` will not be automatically translated.
  /// make sure to supply it with the proper translated text.
  /// 
  static error(String message, {String title}) {
    openSnackbar(
      title ?? 'error'.tr,
      message,
      bgColor: Colors.red[400],
      textColor: Colors.white,
    );
  }
}
