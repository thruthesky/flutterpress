class PostModel {
  dynamic data;

  int id;
  int authorId;
  String authorName;
  String title;
  String content;
  String slug;

  List<CommentModel> comments;

  PostModel({
    this.data,
    this.id,
    this.authorId,
    this.authorName,
    this.title,
    this.content,
    this.slug,
    this.comments,
  });

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

    data['comments'].map((c) => CommentModel.fromBackendData(c));

    return PostModel(
        data: data,
        id: data['ID'],
        authorId: int.parse(data['post_author']),
        authorName: data['author_name'],
        title: data['post_title'],
        content: data['post_content'],
        slug: data['slug'],
        comments: _comments);
  }

  bool deleted = false;

  insertComment(int parent, CommentModel comment) {
    if (parent == 0) {
      comments.insert(0, comment); // Add to first
    } else {
      // repply ....
    }
  }

  delete() {
    deleted = true;
    content = '( deleted )';
    title = '( deleted )';
    id = 0;
  }

  update(PostModel post) {
    data = post.data;
    title = post.title;
    content = post.content;
    slug = post.slug;
  }

  @override
  String toString() {
    return data.toString();
  }
}

class CommentModel {
  dynamic data;
  int id;
  int postId;
  int userId;
  int parent;
  String author;
  String content;
  int depth;

  CommentModel({
    this.data,
    this.id,
    this.postId,
    this.userId,
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
        userId: int.parse(data['user_id']),
        parent: int.parse(data['comment_parent']),
        author: data['comment_author'],
        content: data['comment_content'],
        depth: data['depth']);
  }

  bool deleted = false;

  delete() {
    this.deleted = true;
    author = '( deleted )';
  }

  update(CommentModel comment) {
    data = comment;
    content = comment.content;
  }
}
