class UserModel {
  dynamic data;
  int id;
  String userEmail;
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


  bool get hasMobile => mobile != null && mobile.toString().length > 7;

  UserModel({
    this.data,
    this.id,
    this.userEmail,
    this.nickName,
    this.firstName,
    this.lastName,
    this.userLogin,
    this.photoURL,
    this.sessionId,
    this.firebaseUID,
    this.firebaseToken,
    this.socialLogin,
  });



  factory UserModel.fromBackendData(dynamic data) {
    if (data is String) {
      return UserModel(data: data);
    }
    return UserModel(
      data: data,
      id: int.parse(data['ID']), // User's ID from backend is string.
      userEmail: data['user_email'],
      nickName: data['nickname'],
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      userLogin: data['user_login'],
      photoURL: data['photo_url'] ?? '',
      sessionId: data['session_id'],
      firebaseUID: data['firebase_uid'],
      firebaseToken: data['firebase_custom_login_token'],
      socialLogin: data['social_login'] ?? '',
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
