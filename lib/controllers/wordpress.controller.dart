import 'package:dio/dio.dart';
import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.config.dart';
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

  /// This adds a single post to a list.
  ///
  /// This is used under [postEdit] and [getPost] method.
  _addPostToList(Map<String, dynamic> postData) {
    posts.insert(0, PostModel.fromBackendData(postData));
  }

  /// Updates an specific post on the list.
  ///
  _updatePost(Map<String, dynamic> postData) {
    var id = postData['ID'];
    int i = posts.indexWhere((post) => post.id == id);
    posts.replaceRange(i, i + 1, [PostModel.fromBackendData(postData)]);
  }

  /// This will make an Http request for editting post.
  ///
  /// Editting can either be creating or updating.
  postEdit(Map<String, dynamic> params, {isUpdate = false}) async {
    params['route'] = 'post.edit';
    params['session_id'] = user.sessionId;
    if (isEmpty(params['slug']) && !isUpdate) {
      params['slug'] = 'uncategorized';
    }

    var reqs = ['post_title'];
    if (isUpdate) reqs.add('ID');

    var postData = await getHttp(params, require: reqs);

    if (isUpdate) {
      _updatePost(postData);
    } else {
      _addPostToList(postData);
    }

    update(['postList']);
  }

  /// Delete an existing post.
  ///
  postDelete(Map<String, dynamic> params) async {
    params['route'] = 'post.delete';
    params['session_id'] = user.sessionId;

    var data = await getHttp(params, require: ['ID']);
    posts.removeWhere((post) => post.id == data['ID']);
    update(['postList']);
  }

  /// Get a single post from backend.
  ///
  getPost() {}

  /// Gets more than one posts
  ///
  /// To get only one post, use [getPost]
  getPosts(Map<String, dynamic> params) async {
    params['route'] = 'post.search';
    List<dynamic> ps = await getHttp(params);
    ps.forEach((post) => _addPostToList(post));
    update(['postList']);
  }

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
