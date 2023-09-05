class PostModel {
  final int userId;
  final String title;
  final int id;
  final String body;

  PostModel(
      {this.title = "no title",
      this.userId = 0,
      this.body = "no url",
   
      this.id = 0});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
    
    );
  }
}
