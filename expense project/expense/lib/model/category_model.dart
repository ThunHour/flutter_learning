import 'dart:convert';

List<CategoryModel> categoryModelFromMap(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromMap(x)));

String categoryModelToMap(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CategoryModel {
    CategoryModel({
              this.cId="no id",
        this.cTitle="no title",
        this.cColor="no color",
        this.userId="no userID",
    });

    String cId;
    String cTitle;
    String cColor;
    String userId;

    factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        cId: json["c_id"]??"no id",
        cTitle: json["c_title"]??"no title",
        cColor: json["c_color"]??"no color",
        userId: json["userId"]??"no userID",
    );

    Map<String, dynamic> toMap() => {
        "c_id": cId,
        "c_title": cTitle,
        "c_color": cColor,
        "userId": userId,
    };
}
