class VoteModel {
  // {"ID":81,"like":"1","dislike":"","user_vote":"like"}

  int id;
  String like;
  String dislike;
  String userVote;

  VoteModel({
    this.id,
    this.like,
    this.dislike,
    this.userVote,
  });

  factory VoteModel.fromBackendData(Map<String, dynamic> data) {
    return VoteModel(
      id: data['id'],
      like: data['like'],
      dislike: data['dislike'],
      userVote: data['user_vote'],
    );
  }
}
