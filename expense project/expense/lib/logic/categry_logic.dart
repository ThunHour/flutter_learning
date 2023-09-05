import 'dart:convert';

import 'package:expense/logic/token.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import '../model/category_model.dart';

class CategoryLogic extends ChangeNotifier {
  String _token = "";
  void setToken(String tok) {
    _token = tok;
  }

  Map<String, String> get headersCus => {
        "Authorization": "Bearer $_token",
      };
  List<CategoryModel> listCate = [];
  List<CategoryModel> get listOfCate => listCate;

  Future<bool> insertCate(CategoryModel cate) async {
    try {
      String url = "http://10.0.2.2:3000/api/category";
      http.Response response = await http.post(Uri.parse(url),
          body: cate.toMap(), headers: headersCus);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["result"] ==
            "Category Inserted Successful") {
          readCate();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  Future<bool> editCate(CategoryModel cate) async {
    try {
      String url = "http://10.0.2.2:3000/api/category/${cate.cId}";
      http.Response response = await http.patch(Uri.parse(url),
          body: cate.toMap(), headers: headersCus);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        if (json.decode(response.body)["result"] ==
            "Category Updated Successful") {
          await readCate();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  Future<bool> deleteCat(CategoryModel cate) async {
    try {
      String url = "http://10.0.2.2:3000/api/category/${cate.cId}";
      http.Response response =
          await http.delete(Uri.parse(url), headers: headersCus);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["result"] ==
            "Category Deleted Successful") {
          await readCate();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  Future<void> readCate() async {
    try {
      String url = "http://10.0.2.2:3000/api/category";
      http.Response response =
          await http.get(Uri.parse(url), headers: headersCus);
      if (response.statusCode == 200) {
        listCate = await compute(_convert, response.body);
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
  }
}

List<CategoryModel> _convert(String body) {
  List list = json.decode(body);
  return list.map((e) => CategoryModel.fromMap(e)).toList();
}
