import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/controllers/wordpress.controller.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/flutterbase_v2/flutterbase.defines.dart';
import 'package:flutterpress/models/forum_base.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:flutterpress/services/app.globals.dart';
import 'package:flutterpress/services/keys.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
                key: ValueKey(Keys.dialogConfirmButton),
                onPressed: onConfirm != null
                    ? () {
                        Get.back();
                        onConfirm();
                      }
                    : null,
                child: Text(textConfirm ?? 'yes'.tr),
              ),
              Spacer(),
              FlatButton(
                key: ValueKey(Keys.dialogCancelButton),
                onPressed: () {
                  Get.back();
                  if (onCancel != null) onCancel();
                },
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
  static error(dynamic message, {String title}) {
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
    bool showLogs = false,
  }) async {
    Dio dio = Dio();

    if (isEmpty(params['route'])) throw 'route empty happend on client';
    if (require != null) {
      require.forEach((e) {
        if (isEmpty(params[e])) throw e + '_empty';
      });
    }

    if (showLogs) dio.interceptors.add(LogInterceptor());

    Response response;

    try {
      response = await dio.get(
        AppConfig.apiUrl,
        queryParameters: params,
      );
    } catch (e) {
      // TODO: Handle errors
      throw 'Unexpected error happened!';
    }

    if (response.data is String) throw response.data;
    return response.data;
  }

  /// check if the `item` belongs to the current logged in user.
  ///
  /// item can be either a model of `PostModel` or `CommentModel`.
  static bool isMine(ForumBaseModel item) {
    if (wc.isUserLoggedIn == false) return false;
    if (item == null) return false;

    /// it is safe to check for this since both Model have the same property.
    if (item.deleted) return false;
    return item.authorId == wc.user.id;
  }

  static String isValidEmail(String email) {
    if (isEmpty(email)) return 'user_email_empty'.tr;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email) ? null : 'invalid_email_format'.tr;
  }

  static String isValidPassword(String pass) {
    if (isEmpty(pass)) return 'user_pass_empty'.tr;
    if (pass.length < 6) return 'password_too_short'.tr;
    return null;
  }

  /// image picker
  ///
  /// Example)
  ///```
  ///   var image = await AppService.pickImage(
  ///       context,
  ///       index,
  ///       maxWidth: 640,
  ///       imageQuality: 80,
  ///    );
  ///```
  static Future<File> pickImage(
    context,
    ImageSource source, {
    double maxWidth = 1024,
    int imageQuality = 80,
  }) async {
    final picker = ImagePicker();
    File file;

    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    bool haveAccess = await checkPermission(permission);

    if (haveAccess) {
      PickedFile pickedFile = await picker.getImage(
        source: source,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
      );
      if (!isEmpty(pickedFile)) {
        file = await compressAndGetImage(File(pickedFile.path));
      }
    }
    return file;
  }

  static isFirebaseError(e) {
    return e.runtimeType.toString() == "FirebaseAuthException";
  }

  static getFirebaseErrorData(e) {
    print('handleFirebaseError(): e.runtimeType: ' + e.runtimeType.toString());
    print(e);
    if (e.code == ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL) {
      return {
        'title': '중복 소셜 로그인',
        'message': '동일한 메일 주소의 다른 소셜 아이디로 이미 로그인되어져 있습니다. 다른 소셜아이디로 로그인을 하세요.',
      };
    } else {
      print('code: ${e.code}');
      print('message: ${e.message}');
      return {
        'title': e.code,
        'message': e.message,
      };
    }
  }

  static alertError(dynamic e) {
    Map<dynamic, dynamic> data = {
      'title': '',
      'message': '',
    };
    if (isFirebaseError(e)) {
      data = getFirebaseErrorData(e);
    } else {
      data['title'] = 'Backend error';
      data['message'] = e;
    }
    Get.snackbar(data['title'], data['message'],
        duration: Duration(seconds: 10));
  }


  static String getKakaoEmail(user) {
    
    
      String email;
      if ( user.properties['email'] != null ) {
        email = user.properties['email'];
      } else {
        email = 'kakaotalk${user.id}@kakao.com';
      }
      return email;
  }
}
