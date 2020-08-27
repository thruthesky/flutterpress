import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:flutterpress/services/app.keys.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppService {
  static final WordpressController wc = Get.find();

  static Future initBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBox.user);
  }

  static confirmDialog(
    String title,
    Widget content, {
    String textConfirm,
    String textCancel,
    Function onConfirm,
    Function onCancel,
  }) async {
    await Get.dialog(
      SimpleDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              height: 10,
            ),
            content
          ],
        ),
        children: [
          Divider(),
          Row(
            children: [
              FlatButton(
                key: ValueKey(AppKeys.dialogConfirmButton),
                onPressed: onConfirm,
                child: Text('yes'.tr),
              ),
              Spacer(),
              FlatButton(
                key: ValueKey(AppKeys.dialogCancelButton),
                onPressed: onCancel,
                child: Text('cancel'.tr),
              ),
            ],
          )
        ],
      ),
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

  static Future<dynamic> getHttp(
    Map<String, dynamic> params, {
    List<String> require,
  }) async {
    Dio dio = Dio();

    if (isEmpty(params['route'])) throw 'route empty happend on client';
    if (require != null) {
      require.forEach((e) {
        if (isEmpty(params[e])) throw e + '_empty';
      });
    }

    dio.interceptors.add(LogInterceptor());
    Response response = await dio.get(
      AppConfig.apiUrl,
      queryParameters: params,
    );
    if (response.data is String) throw response.data;
    return response.data;
  }

  static isMyPost(PostModel post) {
    if (wc.isUserLoggedIn == false) return false;
    if (post == null) return false;
    if (post.deleted) return false;

    return post.authorId == wc.user.id;
  }
}
