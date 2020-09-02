class FileModel {
  dynamic data;

  String url;
  String thumbnailUrl;
  String id;
  String name;

  FileModel({this.data, this.url, this.thumbnailUrl, this.id});

  factory FileModel.fromBackendData(Map<String, dynamic> data) {
    if (data is String) {
      return FileModel(data: data);
    }
    return FileModel(
      data: data,
      url: data['url'],
      thumbnailUrl: data['url'],
      id: data['ID'],
    );
  }

  @override
  String toString() {
    return data.toString();
  }
}
