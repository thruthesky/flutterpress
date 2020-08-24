import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:get/state_manager.dart';

class WordpressController extends GetxController {
  UserModel user;

  bool get isUserLoggedIn => user != null;

  Future<dynamic> getHttp(dynamic params) async {
    Dio dio = Dio();

    dio.interceptors.add(LogInterceptor());
    Response response = await dio.get(
      AppConfig.apiUrl,
      queryParameters: params,
    );

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

  /// Updates the user instance and notify or update listeners
  /// .
  updateUser(UserModel user) {
    this.user = user;
    update();
  }

  /// Handle user related http request.
  ///
  /// Ex) user login
  /// ```dart
  ///   final params = {'user_email': userEmail, 'user_pass': userPass};
  ///   params['route'] = 'user.login';
  ///   return await userRequest(params);
  /// ```
  Future<UserModel> userRequest(dynamic params) async {
    if (params['route'] == null || params['route'] == '')
      throw 'route_param_empty';

    dynamic re = await getHttp(params);
    if (re is String) throw re; // error string from backend.

    updateUser(UserModel.fromJson(re));
    return user;
  }

  /// Login a user.
  ///
  /// ```
  ///   WordpressController
  ///     .login(userEmail: 'berry@test.com', userPass: 'berry@test.com')
  ///       .then((value) => print(value))
  ///       .catchError((e) => print(e));
  /// ```
  Future<UserModel> login({
    @required String userEmail,
    @required String userPass,
  }) async {
    if (userEmail == null || userEmail == '') throw 'email_is_empty';
    if (userEmail == null || userEmail == '') throw 'password_is_empty';

    final params = {'user_email': userEmail, 'user_pass': userPass};
    params['route'] = 'user.login';

    return await userRequest(params);
  }

  /// Register a new user.
  ///
  /// ```
  ///   WordpressController
  ///     .register(userEmail: 'berry@test.com', userPass: 'berry@test.com')
  ///       .then((value) => print(value))
  ///       .catchError((e) => print(e));
  /// ```
  ///
  /// TODO: Update additional parameters like first_name, last_name, nickname, etc.
  Future<UserModel> register({
    @required String userEmail,
    @required String userPass,
  }) async {
    if (userEmail == null || userEmail == '') throw 'email_is_empty';
    if (userPass == null || userPass == '') throw 'password_is_empty';

    final params = {'user_email': userEmail, 'user_pass': userPass};
    params['route'] = 'user.register';

    return await userRequest(params);
  }

  /// Get user information from the backend.
  ///
  profile() {}

  /// Update user information.
  ///
  profileUpdate() {}

  /// Logouts the current logged in user.
  ///
  logout() {
    updateUser(null);
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
