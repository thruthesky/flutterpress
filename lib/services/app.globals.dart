import 'package:flutterpress/services/app.routes.dart';
import 'package:get/route_manager.dart';

openForum(String slug) {
  Get.toNamed(AppRoutes.postList, arguments: {'slug': slug});
}
