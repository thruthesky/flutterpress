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
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
