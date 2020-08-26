class PostModel {
  dynamic data;

  int id;
  String postAuthor;
  String title;
  String content;
  String slug;

  PostModel({
    this.data,
    this.id,
    this.postAuthor,
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
      postAuthor: data['post_author'],
      title: data['post_title'],
      content: data['post_content'],
      slug: data['slug'],
    );
  }
}
