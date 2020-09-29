import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/models/post.model.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:flutterpress/services/app.service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class WordpressController extends GetxController {
  WordpressController() {
    _initCurrentUser();
  }

  Box userBox = Hive.box(HiveBox.user);

  UserModel user = UserModel();

  bool get isUserLoggedIn => user.id != null;

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
  UserModel _updateCurrentUser(Map<String, dynamic> res) {
    user = UserModel.fromBackendData(res);
    userBox.put(BoxKey.currentUser, res);
    this.user = user;
    update();

    /// @add return
    return user;
  }

  /// Login a user.
  ///
  Future<UserModel> login(Map<String, dynamic> params) async {
    params['route'] = 'user.login';
    var data = await AppService.getHttp(
      params,
      require: ['user_email', 'user_pass'],
    );
    return _updateCurrentUser(data);
  }

  /// Register a new user.
  ///
  Future<UserModel> register(Map<String, dynamic> params) async {
    params['route'] = 'user.register';
    var data = await AppService.getHttp(params, require: [
      'user_email',
      'user_pass',
      // 'nickname',
    ]);
    return _updateCurrentUser(data);
  }

  /// Register or Login a user after social login process
  ///
  ///
  Future<UserModel> loginOrRegister(Map<String, dynamic> params) async {
    // print(params);
    try {
      // print('login');
      var u = await login(params);
      // print(u.toString());
      return u;
    } catch (e) {
      if (e == 'user_not_found_by_that_email') {
        // print('======> User is not registered in Backend: Going to register');
        try {
          // print('login');
          var u = await register(params);
          // print(u.toString());
          return u;
        } catch (e) {
          throw e;
        }
      } else {
        throw e;
      }
    }
  }

  /// Update user information.
  ///
  Future<UserModel> profileUpdate(Map<String, dynamic> params) async {
    params['route'] = 'user.update';
    params['session_id'] = user.sessionId;
    var data = await AppService.getHttp(params);
    return _updateCurrentUser(data);
  }

  /// Resigns or removes the user information from the backend.
  ///
  Future resign() async {
    await AppService.getHttp({
      'route': 'user.resign',
      'session_id': user.sessionId,
    });
    logout();
  }

  /// Logouts the current logged in user.
  ///
  logout() {
    user = UserModel();
    userBox.delete(BoxKey.currentUser);
    update();
  }

  /// Social login
  ///
  Future<UserModel> socialLogin(User fbUser) async {
    final String uid = fbUser.uid;
    final String provider = fbUser.providerData[0].providerId;

    final params = {
      'route': 'user.firebaseSocialLogin',
      'firebase_uid': uid,
      'provider': provider,
      'email': fbUser.email,
      'name': fbUser.displayName
    };

    var result = await AppService.getHttp(params);

    print('socialLogin:: firebaseSocialLogin');
    print(result);

    return _updateCurrentUser(result);
  }

  Future<dynamic> phoneAuthCodeVerification({
    String sessionID,
    String verificationCode,
    String mobileNo,
  }) async {
    var result = await AppService.getHttp({
      'route': 'user.verifyPhoneVerificationCode',
      'sessionInfo': sessionID,
      'code': verificationCode,
      'mobile': mobileNo,
      'session_id': user.sessionId,
    });
    // print('phoneAuthCodeVerification:: Result');
    // print(result);
    return result;
  }

  updateUserMobile(String mobile) {
    user.mobile = mobile;
    update();
  }

  /// This will make an Http request for fetching posts.
  ///
  Future<List<PostModel>> getPosts({
    String slug,
    int postsPerPage,
    int page = 1,
  }) async {
    List<PostModel> posts = [];
    Map<String, dynamic> re;
    re = await AppService.getHttp({
      'route': 'post.search',
      'slug': slug ?? 'uncategorized',
      'posts_per_page': postsPerPage ?? AppConfig.noOfPostsPerPage,
      'paged': page,
    }, require: [
      'slug'
    ]);
    re.remove('route');
    if (isEmpty(re)) return posts;
    re.forEach((key, value) => posts.add(PostModel.fromBackendData(value)));
    return posts;
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

    var res = await AppService.getHttp(params, require: reqs, showLogs: true);
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
    // print(params);
    var data = await AppService.getHttp(params, require: ['comment_ID']);
    // print(data);
    return CommentModel(id: data['ID'], data: data);
  }

  /// vote for a post or comment.
  /// performs like and dislike.
  ///
  Future<VoteModel> _vote(Map<String, dynamic> params) async {
    if (isEmpty(user)) throw 'Login first!';
    params['session_id'] = user.sessionId;

    var data = await AppService.getHttp(params, require: ['ID', 'choice']);
    return VoteModel.fromBackendData(data);
  }

  Future<VoteModel> postVote(Map<String, dynamic> params) async {
    params['route'] = 'post.vote';
    return _vote(params);
  }

  Future<VoteModel> commentVote(Map<String, dynamic> params) async {
    params['route'] = 'comment.vote';
    return _vote(params);
  }

  /// Upload a file to backend.
  Future<FileModel> fileUpload(
    File image, {
    String fileName = '',
    bool custom = false,
    void onUploadProgress(double progress),
  }) async {
    Dio dio = Dio();

    if (!isUserLoggedIn) {
      throw 'login_first';
    }
    if (fileName == '') {
      var now = new DateTime.now();
      final num ms = now.millisecondsSinceEpoch;

      fileName = '${user.id}-$ms.png';
    }

    FormData formData = FormData();
    formData.fields.addAll([
      MapEntry('session_id', user.sessionId),
      MapEntry('route', 'file.upload'),
    ]);

    formData.files.add(MapEntry(
      'userfile',
      await MultipartFile.fromFile(image.path, filename: fileName),
    ));

    dio.interceptors.add(LogInterceptor());
    var response = await dio.post(
      AppConfig.apiUrl,
      data: formData,
      onSendProgress: (received, total) {
        double progress = received / total;
        progress = double.parse(progress.toStringAsFixed(3));
        onUploadProgress(progress);
      },
    );
    if (response.data is String) throw response.data;
    print('responseData');
    print(response.data);
    return FileModel.fromBackendData(response.data);
  }

  /// Delete an existing file from backend.
  ///
  Future<FileModel> fileDelete(Map<String, dynamic> params) async {
    params['route'] = 'file.delete';
    params['session_id'] = user.sessionId;

    var data = await AppService.getHttp(params);
    return FileModel(id: data['ID']);
  }

  password(salt) {
    return '$salt/Password~9.,*';
  }
}
