import 'package:flutterpress/models/forum_base.model.dart';

class CommentModel extends ForumBaseModel {
  int postId;
  int parent;
  int depth;

  CommentModel({
    this.postId,
    this.parent,
    this.depth,
    data,
    id,
    like,
    dislike,
    authorId,
    authorName,
    authorPhotoUrl,
    content,
    date,
    files,
  }) : super(
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
          deleted: false,
        );

  factory CommentModel.fromBackendData(dynamic data) {
    if (data is String) {
      return CommentModel(data: data);
    }

    return CommentModel(
      postId: int.parse(data['comment_post_ID']),
      parent: int.parse(data['comment_parent']),
      depth: data['depth'],
      data: data,
      id: int.parse(data['comment_ID']),
      like: data['like'],
      dislike: data['dislike'],
      authorId: int.parse(data['user_id']),
      authorName: data['comment_author'],
      authorPhotoUrl: data['author_photo_url'] ?? '',
      content: data['comment_content'] ?? '',
      date: data['short_date_time'],
      files: data['files'],
    );
  }

  update(CommentModel comment) {
    data = comment;
    content = comment.content;
  }
}
