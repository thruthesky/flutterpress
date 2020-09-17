import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:intl/intl.dart';

class CommentModel {
  dynamic data;
  int id;
  int postId;
  int authorId;
  int parent;
  int like;
  int dislike;
  String author;
  String authorPhotoUrl;
  String content;
  int depth;

  String date;

  List<FileModel> files;

  CommentModel({
    this.data,
    this.id,
    this.like,
    this.dislike,
    this.postId,
    this.authorId,
    this.parent,
    this.author,
    this.authorPhotoUrl,
    this.content,
    this.depth,
    this.date,
    files,
  }) : this.files = files ?? [];

  factory CommentModel.fromBackendData(dynamic data) {
    if (data is String) {
      return CommentModel(data: data);
    }

    List<FileModel> _files = [];
    if (data['files'] != null && data['files'].length > 0) {
      _files = data['files'].map<FileModel>((f) {
        return FileModel.fromBackendData(f);
      }).toList();
    }


    final dateNow = DateFormat('yyyy-MM-dd').format(new DateTime.now());

    final String _date = dateNow == data['short_date_time']
        ? data['post_date'].split(' ').last
        : data['short_date_time'];
    
    final _like = data['like'] != null ? data['like'] : 0;
    final _dislike = data['dislike'] != null ? data['dislike'] : 0;

    return CommentModel(
      data: data,
      id: int.parse(data['comment_ID']),
      like: _like is int ? _like : int.parse(_like),
      dislike: _dislike is int ? _dislike : int.parse(_dislike),
      postId: int.parse(data['comment_post_ID']),
      authorId: int.parse(data['user_id']),
      parent: int.parse(data['comment_parent']),
      author: data['comment_author'],
      authorPhotoUrl: data['author_photo_url'] ?? '',
      content: data['comment_content'] ?? '',
      depth: data['depth'],
      date: _date,
      files: _files,
    );
  }

  bool deleted = false;

  delete() {
    this.deleted = true;
    content = '';
    author = '( deleted )';
  }

  update(CommentModel comment) {
    data = comment;
    content = comment.content;
  }

  updateVote(VoteModel vote) {
    like = vote.like;
    dislike = vote.dislike;
  }

  deleteFile(FileModel file) {
    files.removeWhere((f) => f.id == file.id);
  }
}
