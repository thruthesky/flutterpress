class PostModel {
  dynamic data;

  int id;
  int authorId;
  String authorName;
  String title;
  String content;
  String slug;

  PostModel({
    this.data,
    this.id,
    this.authorId,
    this.authorName,
    this.title,
    this.content,
    this.slug,
  });

  factory PostModel.fromBackendData(dynamic data) {
    if (data is String) {
      return PostModel(data: data);
    }
    return PostModel(
      data: data,
      id: data['ID'],
      authorId: int.parse(data['post_author']),
      authorName: data['author_name'],
      title: data['post_title'],
      content: data['post_content'],
      slug: data['slug'],
    );
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
