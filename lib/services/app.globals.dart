import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutterpress/services/app.routes.dart';
import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';

openForum(String slug) {
  Get.toNamed(AppRoutes.postList, arguments: {'slug': slug});
}

const double xs = 8;
const double sm = 12;
const double md = 16;
const double lg = 24;
const double xl = 32;
const double xxl = 64;

/// it evaluates the status
///
bool evaluatePermissionStatus(PermissionStatus status) {
  return status.isUndetermined || status.isGranted ? true : false;
}

/// `check permission` for certain device function access
///
Future<bool> checkPermission(Permission permissionGroup) async {
  PermissionStatus permissionStatus = await permissionGroup.status;
  return evaluatePermissionStatus(permissionStatus);
}

/// `request permission` for certain device function access
Future<bool> requestPermission(Permission permission) async {
  PermissionStatus status = await permission.request();
  return evaluatePermissionStatus(status);
}

/// check for permission for
/// Android: Camera
/// iOS: Photos (Camera Roll and Camera)
Future<bool> hasCameraPermission() async {
  return checkPermission(Permission.camera);
}

/// check for permission for
/// Android: Nothing
/// iOS: Photos
Future<bool> hasPhotoLibraryPermission() async {
  return checkPermission(Permission.photos);
}

/// compress file and returns it.
/// also fixing orientation issue when taking images via camera.
Future<File> compressAndGetImage(File image) async {
  if (image == null) return null;
  var fileAsBytes = await image.readAsBytes();
  await image.delete();
  final compressedImageBytes =
      await FlutterImageCompress.compressWithList(fileAsBytes);
  await image.writeAsBytes(compressedImageBytes);
  return image;
}
