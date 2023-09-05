class Photomodel {
  final int id;
  final String title;
  final int albumId;
  final String url;
  final String thumbnaiUrl;

  Photomodel(
      {this.title = "no title",
      this.albumId = 0,
      this.url = "no url",
      this.thumbnaiUrl = "no ",
      this.id = 0});

  factory Photomodel.hour(Map<String, dynamic> map) {
    return Photomodel(
      albumId: map['albumId'],
      id: map['id'],
      title: map['title'],
      url: map['url'],
      thumbnaiUrl: map['thumbnailUrl'],
    );
  }
}
