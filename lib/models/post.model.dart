import 'package:flutterpress/models/comment.model.dart';
import 'package:flutterpress/models/forum_base.model.dart';

class PostModel extends ForumBaseModel {
  String title;
  String slug;
  List<CommentModel> comments;

  int get commentCount => comments.length;

  PostModel({
    this.title,
    this.slug,
    data,
    id,
    like,
    dislike,
    authorId,
    authorName,
    authorPhotoUrl,
    content,
    files,
    date,
    deleted,
    this.comments = const <CommentModel>[],
  }) :
        super(
          data: data,
          id: id,
          like: like,
          dislike: dislike,
          authorId: authorId,
          authorName: authorName,
          authorPhotoUrl: authorPhotoUrl,
          content: content,
          files: files,
          date: date,
        );

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

    return PostModel(
      slug: data['slug'],
      comments: _comments,
      title: data['post_title'],
      data: data,
      id: data['ID'],
      like: data['like'],
      dislike: data['dislike'],
      authorId: int.parse(data['post_author']),
      authorName: data['author_name'],
      authorPhotoUrl: data['author_photo_url'],
      content: data['post_content'] ?? '',
      files: data['files'],
      date: data['short_date_time'],
      deleted: false,
    );
  }

  insertComment(int commentParentId, CommentModel comment) {
    int i = 0;
    int depth = 1;
    if (commentParentId > 0) {
      i = comments.indexWhere((c) {
            depth = c.depth + 1;
            return c.id == commentParentId;
          }) +
          1;
    }
    comment.depth = depth;
    comments.insert(i, comment);
  }

  update(PostModel post) {
    data = post.data;
    title = post.title;
    content = post.content;
    slug = post.slug;
  }
}
