class UserModel {
  dynamic data;
  int id;
  String email;
  String nickName;
  String firstName;
  String lastName;
  String userLogin;
  String photoURL;
  String sessionId;
  String firebaseUID;
  String firebaseToken;
  String socialLogin;
  String mobile;
  String birthday;

  bool get hasMobile => mobile != null && mobile.toString().length > 7;

  bool get isRegisteredWithWordpress => socialLogin == 'wordpress';

  UserModel({
    this.data,
    this.id,
    this.email,
    this.nickName,
    this.firstName,
    this.lastName,
    this.userLogin,
    this.photoURL,
    this.sessionId,
    this.firebaseUID,
    this.firebaseToken,
    this.socialLogin,
    this.mobile,
    this.birthday,
  });

  factory UserModel.fromBackendData(dynamic data) {
    if (data is String) {
      return UserModel(data: data);
    }

    final String _provider =
        data['social_login'] != null && data['social_login'] != ''
            ? data['social_login'].split('.')[0]
            : 'wordpress';

    return UserModel(
      data: data,
      id: int.parse(data['ID']), // User's ID from backend is string.
      email: data['user_email'],
      nickName: data['nickname'],
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      userLogin: data['user_login'],
      photoURL: data['photo_url'] ?? '',
      sessionId: data['session_id'],
      firebaseUID: data['firebase_uid'],
      firebaseToken: data['firebase_custom_login_token'],
      mobile: data['mobile'] ?? '',
      birthday: data['birthday'] ?? '',
      socialLogin: _provider,
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
