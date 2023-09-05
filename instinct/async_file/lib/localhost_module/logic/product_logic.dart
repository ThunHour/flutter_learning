import 'dart:convert';

import 'package:async_file/localhost_module/models/product_model.dart';
import "package:http/http.dart" as http;

import 'package:flutter/foundation.dart';

import '../constant/base_url_constant.dart';
import '../constant/enum_product.dart';

class ProductLogic extends ChangeNotifier {
  ProductModel _productList = ProductModel();
  ProductModel get productlist => _productList;

  List<Product> _resultList = [];
  List<Product> get result => _resultList;

  ProductStatus _status = ProductStatus.none;
  ProductStatus get statue => _status;

  void setLoading() {
    _status = ProductStatus.loading;
    notifyListeners();
  }

  Future read() async {
    try {
      const url = readUrl;
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        ProductModel local =
            _productList = await compute(_convert, response.body);
        _resultList = local.products;

        _status = ProductStatus.success;
      } else {
        print("Error while reading data, status code: ${response.statusCode}");
        _status = ProductStatus.error;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      _status = ProductStatus.error;
    }
    notifyListeners();
  }

  Future<bool> insert(Product item) async {
    try {
      const url = inertUrl;
      http.Response response =
          await http.post(Uri.parse(url), body: item.toMap());
      print(response.body);
      if (response.statusCode == 200) {
        if (response.body == "product_inserted") {
          return true;
        }
      } else {
        throw Exception("Error while reading data");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  Future<bool> update(Product item) async {
    try {
      const url = updateUrl;
      http.Response response =
          await http.post(Uri.parse(url), body: item.toMap());
      if (response.statusCode == 200) {
        if (response.body == "product_updated") {
          return true;
        }
      } else {
        throw Exception("Error while reading data");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }

  Future<bool> delete(Product item) async {
    try {
      const url = deleteUrl;
      http.Response response = await http.post(
        Uri.parse(url),
        body: item.toMap(),
      );
      if (response.statusCode == 200) {
        if (response.body == "product_deleted") {
          return true;
        }
      } else {
        throw Exception("Error while reading data");
      }
    } catch (e) {
      throw Exception("Error ${e.toString()}");
    }
    return false;
  }
}

ProductModel _convert(String body) {
  return ProductModel.fromMap(json.decode(body));
}
