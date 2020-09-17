import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/models/vote.model.dart';

class ForumBaseModel {
  dynamic data;
  int id;
  int authorId;
  String authorName;
  String authorPhotoUrl;
  String content;
  bool deleted;

  int like;
  int dislike;
  String date;
  List<FileModel> files;

  ForumBaseModel({
    this.data,
    this.id,
    this.authorId,
    this.authorName,
    this.authorPhotoUrl,
    this.content,
    this.deleted = false,
    this.date,
    files = const <FileModel>[],
    like,
    dislike,
  }) {
    List<FileModel> _files = [];
    if (files != null && files.length > 0) {
      _files = files.map<FileModel>((f) {
        return FileModel.fromBackendData(f);
      }).toList();
    }

    final _like = like != null ? like : 0;
    final _dislike = dislike != null ? dislike : 0;

    this.files = _files;
    this.like = _like is int ? _like : int.parse(_like);
    this.dislike = _dislike is int ? _dislike : int.parse(_dislike);
  }

  delete() {
    this.deleted = true;
  }

  updateVote(VoteModel vote) {
    like = vote.like;
    dislike = vote.dislike;
  }

  deleteFile(FileModel file) {
    files.removeWhere((f) => f.id == file.id);
  }

  String toString() {
    return data.toString();
  }
}
