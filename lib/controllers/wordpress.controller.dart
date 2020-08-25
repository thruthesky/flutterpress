import 'package:dio/dio.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';

import 'package:flutterpress/globals.dart' as globals;

class WordpressController extends GetxController {
  WordpressController() {
    /// when `isTestActive` is true, the app is currently running an integration test.
    /// to test for pages which requires having a logged in user, we need to initiate the app with a mock user.
    if (globals.isTestActive) {
      print('==== Integration test is active, logging in mock user ====');
      _updateCurrentUser(globals.testUser);
    } else {
      _initCurrentUser();
    }
  }
  Box userBox = Hive.box(HiveBox.user);
  UserModel user;

  bool get isUserLoggedIn => user != null;

  Future<dynamic> getHttp(Map<String, dynamic> params,
      {List<String> require}) async {
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

  /// Get version of backend API.
  ///
  /// ```dart
  /// wc.version().then((re) => print);
  /// ```
  Future<dynamic> version() async {
    return getHttp({'route': 'app.version'});
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
    var data = await getHttp(params, require: ['user_email', 'user_pass']);
    return _updateCurrentUser(data);
  }

  /// Register a new user.
  ///
  Future<UserModel> register(Map<String, dynamic> params) async {
    params['route'] = 'user.register';
    var data = await getHttp(params, require: [
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
    var data = await getHttp(params);
    return await _updateCurrentUser(data);
  }

  /// Resigns or removes the user information from the backend.
  ///
  Future resign() async {
    await getHttp({'route': 'user.resign', 'session_id': user.sessionId});
    logout();
  }

  /// Logouts the current logged in user.
  ///
  logout() {
    user = null;
    userBox.delete(BoxKey.currentUser);
    update();
  }

  /// Create new post
  ///
  postCreate() {}

  /// Update an existing post.
  ///
  postUpdate() {}

  /// Delete an existing post.
  ///
  postDelete() {}

  /// Get a single post from backend.
  ///
  getPost() {}

  /// Gets more than one posts
  ///
  /// To get only one post, use [getPost]
  getPosts() {}

  /// Create a new comment
  ///
  commentCreate() {}

  /// Update an existing comment.
  ///
  commentUpdate() {}

  /// Delete an existing comment.
  ///
  commentDelete() {}

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
