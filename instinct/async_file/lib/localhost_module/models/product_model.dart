import 'dart:convert';

ProductModel productModelFromMap(String str) => ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
    ProductModel({
        this.products=const [],
    });
    List<Product> products;
    factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        products: List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
    );
    Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
    };
}

class Product {
    Product({
        this.pid="0",
        this.name="no name",
        this.qty="0",
        this.price="0.00",
        this.image="no Image",
        this.outOfStock="0",
    });

    String pid;
    String name;
    String qty;
    String price;
    String image;
    String outOfStock;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        pid: json["pid"]??"0",
        name: json["name"]??"No Name",
        qty: json["qty"]??"0",
        price: json["price"]??"0.00",
        image: json["image"]??"No Image",
        outOfStock: json["out_of_stock"]??"0",
    );

    Map<String, dynamic> toMap() => {
        "pid": pid,
        "name": name,
        "qty": qty,
        "price": price,
        "image": image,
        "out_of_stock": outOfStock,
    };
}
