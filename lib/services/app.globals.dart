import 'package:flutterpress/services/app.routes.dart';
import 'package:get/route_manager.dart';

openForum(String slug) {
  Get.toNamed(AppRoutes.postList, arguments: {'slug': slug});
}

const double xs = 8;
const double sm = 12;
const double md = 16;
const double lg = 24;
const double xl = 32;
const double xxl = 64;