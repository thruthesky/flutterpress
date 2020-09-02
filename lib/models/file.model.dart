class UploadedFile {
  dynamic data;

  String url;
  String thumbnailUrl;
  String id;
  String name;

  UploadedFile({this.data, this.url, this.thumbnailUrl, this.id});

  factory UploadedFile.fromBackendData(Map<String, dynamic> data) {
    if (data is String) {
      return UploadedFile(data: data);
    }
    return UploadedFile(
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
