import 'dart:convert';

ProductModel productModelFromMap(String str) => ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
    ProductModel({
        this.uId="no id",
        this.uGmail="no gmail",
        this.uUsername="no username",
        this.uPassword="no password",
        this.uRole="no role",
        this.uExpense=const [],
        this.uCategory=const [],
    });

    String uId;
    String uGmail;
    String uUsername;
    String uPassword;
    String uRole;
    List<UExpense> uExpense;
    List<UCategory> uCategory;

    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        uId: json["u_id"]??"no id",
        uGmail: json["u_gmail"]??"no gmail",
        uUsername: json["u_username"]??"no username",
        uPassword: json["u_password"]??"no password",
        uRole: json["u_role"]??"no role",
        uExpense: List<UExpense>.from(json["u_expense"].map((x) => UExpense.fromMap(x))),
        uCategory: List<UCategory>.from(json["u_category"].map((x) => UCategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "u_id": uId,
        "u_gmail": uGmail,
        "u_username": uUsername,
        "u_password": uPassword,
        "u_role": uRole,
        "u_expense": List<dynamic>.from(uExpense.map((x) => x.toMap())),
        "u_category": List<dynamic>.from(uCategory.map((x) => x.toMap())),
    };
}

class UCategory {
    UCategory({
        this.cId="no cid",
        this.cTitle="no ctitle",
        this.cColor="no cCOlor",
        this.userId="no user",
    });

    String cId;
    String cTitle;
    String cColor;
    String userId;

    factory UCategory.fromMap(Map<String, dynamic> json) => UCategory(
        cId: json["c_id"]??"no cid",
        cTitle: json["c_title"]??"no ctitle",
        cColor: json["c_color"]??"no ccolor",
        userId: json["userId"]??"no userid",
    );

    Map<String, dynamic> toMap() => {
        "c_id": cId,
        "c_title": cTitle,
        "c_color": cColor,
        "userId": userId,
    };
}

class UExpense {
    UExpense({
        this.eId="no e id",
        this.eDate="no date",
        this.eDes="no des",
        this.ePrice=0,
        this.userId="no user id",
        this.cid="no c id",
    });

    String eId;
    String eDate;
    String eDes;
    int ePrice;
    String userId;
    String cid;

    factory UExpense.fromMap(Map<String, dynamic> json) => UExpense(
        eId: json["e_id"]??"no e id",
        eDate: json["e_date"]??"no date",
        eDes: json["e_des"]??"no des",
        ePrice: json["e_price"]??0,
        userId: json["userId"]??"no user id",
        cid: json["cid"]??"no c id",
    );

    Map<String, dynamic> toMap() => {
        "e_id": eId,
        "e_date": eDate,
        "e_des": eDes,
        "e_price": ePrice,
        "userId": userId,
        "cid": cid,
    };
}
