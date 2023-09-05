class ImageModel {
  ImageModel({
    required this.images,
  });
  late final List<MyImage> images;

  ImageModel.fromJson(Map<String, dynamic> json) {
    images = List.from(json['images']).map((e) => MyImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['images'] = images.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MyImage {
  MyImage({
    required this.imgId,
    this.imageUrl = "no image",
  });
  late final String imgId;
  late final String imageUrl;

  MyImage.fromJson(Map<String, dynamic> json) {
    imgId = json['imageid'];
    imageUrl = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageid'] = imgId;
    _data['url'] = imageUrl;
    return _data;
  }
}
