
class CommentModel {
  dynamic data;
  int id;
  int postId;
  int authorId;
  int parent;
  String author;
  String content;
  int depth;

  CommentModel({
    this.data,
    this.id,
    this.postId,
    this.authorId,
    this.parent,
    this.author,
    this.content,
    this.depth,
  });

  factory CommentModel.fromBackendData(dynamic data) {
    if (data is String) {
      return CommentModel(data: data);
    }
    return CommentModel(
        data: data,
        id: int.parse(data['comment_ID']),
        postId: int.parse(data['comment_post_ID']),
        authorId: int.parse(data['user_id']),
        parent: int.parse(data['comment_parent']),
        author: data['comment_author'],
        content: data['comment_content'],
        depth: data['depth']);
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
}
