class ShopModel {
  ShopModel({
    this.id = 0,
    this.title = "",
    this.price = 0.0,
    this.description = "",
    this.category = "",
    this.image = "",
    required this.rating,
    this.amount=1
  });

  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;
  int amount;

  factory ShopModel.fromMap(Map<String, dynamic> json) => ShopModel(
        id: json["id"] ?? 0,
        title: json["title"] ?? "no title",
        price: json["price"].toDouble() ?? 0.0,
        description: json["description"] ?? "no Description",
        category: json["category"] ?? "no category",
        image: json["image"] ?? "no image",
        rating: Rating.fromMap(json["rating"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toMap(),
      };
}

class Rating {
  Rating({
    this.rate = 0.0,
    this.count = 0,
  });

  double rate;
  int count;

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        rate: json["rate"].toDouble() ?? 0.0,
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "count": count,
      };
}
