import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';

class WordpressController extends GetxController {
  WordpressController() {
    _initCurrentUser();
  }

  Box userBox = Hive.box(HiveBox.user);

  UserModel user;
  List<PostModel> posts = [];

  bool get isUserLoggedIn => user != null;

  /// Get version of backend API.
  ///
  /// ```dart
  /// wc.version().then((re) => print);
  /// ```
  Future<dynamic> version() async {
    return AppService.getHttp({'route': 'app.version'});
  }

  _initCurrentUser() {
    Box userBox = Hive.box(HiveBox.user);
    if (userBox.isNotEmpty) {
      var data = userBox.get(BoxKey.currentUser);
      user = UserModel.fromBackendData(data);
      update();
    }
  }

  /// Updates the user instance and notify or update listeners.
  ///
  _updateCurrentUser(Map<String, dynamic> res) {
    this.user = UserModel.fromBackendData(res);
    userBox.put(BoxKey.currentUser, res);
    update();
  }

  /// Login a user.
  ///
  Future<UserModel> login(Map<String, dynamic> params) async {
    params['route'] = 'user.login';
    var data =
        await AppService.getHttp(params, require: ['user_email', 'user_pass']);
    return _updateCurrentUser(data);
  }

  /// Register a new user.
  ///
  Future<UserModel> register(Map<String, dynamic> params) async {
    params['route'] = 'user.register';
    var data = await AppService.getHttp(params, require: [
      'user_email',
      'user_pass',
      'nickname',
    ]);
    return _updateCurrentUser(data);
  }

  /// Update user information.
  ///
  Future<UserModel> profileUpdate(Map<String, dynamic> params) async {
    params['route'] = 'user.update';
    params['session_id'] = user.sessionId;
    var data = await AppService.getHttp(params);
    return await _updateCurrentUser(data);
  }

  /// Resigns or removes the user information from the backend.
  ///
  Future resign() async {
    await AppService.getHttp(
        {'route': 'user.resign', 'session_id': user.sessionId});
    logout();
  }

  /// Logouts the current logged in user.
  ///
  logout() {
    user = null;
    userBox.delete(BoxKey.currentUser);
    update();
  }

  /// This will make an Http request for editting post.
  ///
  /// Editting can either be creating or updating.
  Future<PostModel> postEdit(
    Map<String, dynamic> params, {
    isUpdate = false,
  }) async {
    params['route'] = 'post.edit';
    params['session_id'] = user.sessionId;
    if (isEmpty(params['slug']) && !isUpdate) {
      params['slug'] = 'uncategorized';
    }

    var reqs = ['post_title'];
    if (isUpdate) reqs.add('ID');

    var res = await AppService.getHttp(params, require: reqs);
    return PostModel.fromBackendData(res);
  }

  /// Delete an existing post.
  ///
  Future<PostModel> postDelete(Map<String, dynamic> params) async {
    params['route'] = 'post.delete';
    params['session_id'] = user.sessionId;

    var data = await AppService.getHttp(params, require: ['ID']);
    return PostModel(id: data['ID'], data: data);
  }

  /// Get a single post from backend.
  ///
  getPost() {}

  /// Create a new comment
  ///
  Future<CommentModel> commentEdit(Map<String, dynamic> params) async {
    params['route'] = 'comment.edit';
    params['session_id'] = user.sessionId;
    var reqs = [
      'comment_content',
      if (isEmpty(params['comment_ID'])) 'comment_post_ID',
    ];
    var res = await AppService.getHttp(params, require: reqs);
    return CommentModel.fromBackendData(res);
  }

  /// Delete an existing comment.
  ///
  Future<CommentModel> commentDelete(Map<String, dynamic> params) async {
    params['route'] = 'comment.delete';
    params['session_id'] = user.sessionId;
    print(params);
    var data = await AppService.getHttp(params, require: ['comment_ID']);
    print(data);
    return CommentModel(id: data['ID'], data: data);
  }

  /// Upload a file to backend.
  ///
  fileUpload() {}

  /// Delete an existing file from backend.
  ///
  fileDelete() {}

  /// Like a post or comment.
  ///
  like() {}

  /// Dislike a post or comment.
  ///
  dislike() {}
}
