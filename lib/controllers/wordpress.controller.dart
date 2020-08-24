import 'package:dio/dio.dart';
import 'package:flutterpress/models/user.model.dart';
import 'package:flutterpress/services/app.config.dart';
import 'package:get/state_manager.dart';

class WordpressController extends GetxController {
  UserModel user;

  Future<dynamic> getHttp(dynamic params) async {
    Dio dio = Dio();

    dio.interceptors.add(LogInterceptor());
    Response response =
        await dio.get(AppConfig.apiUrl, queryParameters: params);
    return response.data;
  }

  /// Get version of backend API
  ///
  /// ```dart
  /// wc.version().then((re) => print);
  /// ```
  Future<dynamic> version() async {
    return getHttp({'route': 'app.version'});
  }

  login() {}
  logout() {}
  Future<UserModel> register(dynamic params) async {
    params['route'] = 'user.register';
    dynamic re = await getHttp(params);
    print(re);
    if (re is String) throw re;

    user = UserModel.fromJson(re);

    return user;
  }

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
