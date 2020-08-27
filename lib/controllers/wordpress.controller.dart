import 'package:flutterpress/defines.dart';
import 'package:flutterpress/flutter_library/library.dart';
import 'package:flutterpress/models/forum.model.dart';
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
  UserModel _updateCurrentUser(Map<String, dynamic> res) {
    this.user = UserModel.fromBackendData(res);
    userBox.put(BoxKey.currentUser, res);
    update();

    /// @add return
    return user;
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
    // if (isUpdate) {
    //   _updatePost(postData);
    // } else {
    //   _addPostToList(postData);
    // }

    // update(['postList']);
  }

  /// Delete an existing post.
  ///
  postDelete(Map<String, dynamic> params) async {
    params['route'] = 'post.delete';
    params['session_id'] = user.sessionId;

    var data = await AppService.getHttp(params, require: ['ID']);
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
    List<dynamic> ps = await AppService.getHttp(params);
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
