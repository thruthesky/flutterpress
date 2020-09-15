class VoteModel {
  // {"ID":81,"like":"1","dislike":"","user_vote":"like"}

  int id;
  int like;
  int dislike;
  String userVote;

  VoteModel({
    this.id,
    this.like,
    this.dislike,
    this.userVote,
  });

  factory VoteModel.fromBackendData(Map<String, dynamic> data) {
    var _like;
    var _dislike;

    if (data['like'] != '') {
      _like = int.parse(data['like']);
    }

    if (data['dislike'] != '') {
      _dislike = int.parse(data['dislike']);
    }

    return VoteModel(
      id: data['id'],
      like: _like ?? 0,
      dislike: _dislike ?? 0 , 
      userVote: data['user_vote'],
    );
  }
}
