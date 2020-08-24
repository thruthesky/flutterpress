import 'package:flutterpress/models/user.model.dart';
import 'package:get/state_manager.dart';

class Controller extends GetxController {
  UserModel? user;

  login() {}
  logout() {}
  register() {}
  profile() {}
  profileUpdate() {}

  postCreate() {}
  postUpdate() {}
  postDelete() {}
  getPost() {}

  /// Gets more than one posts
  ///
  /// To get only one post, use [getPost]
  getPosts() {}
  commentCreate() {}
  commentUpdate() {}
  commentDelte() {}
  fileUpload() {}
  fileDelete() {}
  like() {}
  dislike() {}
}
