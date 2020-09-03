import 'package:flutterpress/models/file.model.dart';

class CommentModel {
  dynamic data;
  int id;
  int postId;
  int authorId;
  int parent;
  String author;
  String content;
  int depth;

  List<FileModel> files;

  CommentModel({
    this.data,
    this.id,
    this.postId,
    this.authorId,
    this.parent,
    this.author,
    this.content,
    this.depth,
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

    return CommentModel(
      data: data,
      id: int.parse(data['comment_ID']),
      postId: int.parse(data['comment_post_ID']),
      authorId: int.parse(data['user_id']),
      parent: int.parse(data['comment_parent']),
      author: data['comment_author'],
      content: data['comment_content'] ?? '',
      depth: data['depth'],
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

  deleteFile(FileModel file) {
    files.removeWhere((f) => f.id == file.id);
  }
}
