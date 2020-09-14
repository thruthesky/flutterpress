import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/file.model.dart';
import 'package:flutterpress/models/vote.model.dart';
import 'package:intl/intl.dart';

class PostModel {
  dynamic data;

  int id;
  int authorId;
  String like;
  String dislike;
  String authorName;
  String authorPhotoUrl;
  String title;
  String content;
  String slug;

  bool deleted;

  List<CommentModel> comments;
  List<FileModel> files;

  String date;
  String time;

  int get commentCount => comments.length;

  PostModel({
    this.data,
    this.id,
    this.like,
    this.dislike,
    this.authorId,
    this.authorName,
    this.authorPhotoUrl,
    this.title,
    this.content,
    this.slug,
    comments,
    files,
    this.date,
    this.deleted,
  })  : this.comments = comments ?? [],
        this.files = files ?? [];

  factory PostModel.fromBackendData(dynamic data) {
    if (data is String) {
      return PostModel(data: data);
    }

    List<CommentModel> _comments = [];
    if (data['comments'] != null && data['comments'].length > 0) {
      _comments = data['comments'].map<CommentModel>((c) {
        return CommentModel.fromBackendData(c);
      }).toList();
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

    return PostModel(
      data: data,
      id: data['ID'],
      like: data['like'] != null ? data['like'] : '0',
      dislike: data['dislike'] != null ? data['dislike'] : '0',
      authorId: int.parse(data['post_author']),
      authorName: data['author_name'],
      authorPhotoUrl: data['author_photo_url'],
      title: data['post_title'],
      content: data['post_content'],
      slug: data['slug'],
      comments: _comments,
      files: _files,
      date: _date,
      deleted: false,
    );
  }

  insertComment(int commentParentId, CommentModel comment) {
    int i = 0;
    double depth = 1;
    if (commentParentId > 0) {
      i = comments.indexWhere((c) {
            depth = c.depth + 1.0;
            return c.id == commentParentId;
          }) +
          1;
    }
    comment.depth = depth;
    comments.insert(i, comment);
  }

  delete() {
    deleted = true;
    content = '';
    title = '( deleted )';
    id = 0;
  }

  deleteFile(FileModel file) {
    files.removeWhere((f) => f.id == file.id);
  }

  update(PostModel post) {
    data = post.data;
    title = post.title;
    content = post.content;
    slug = post.slug;
  }

  updateVote(VoteModel vote) {
    like = vote.like;
    dislike = vote.dislike;
  }

  @override
  String toString() {
    return data.toString();
  }
}
