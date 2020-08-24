class UserModel {
  dynamic data;
  int id;
  String userEmail;
  UserModel({this.data, this.id, this.userEmail});

  factory UserModel.fromJson(dynamic data) {
    if (data is String) {
      return UserModel(data: data);
    }
    return UserModel(
      data: data,
      id: data['ID'],
      userEmail: data['user_email'],
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
