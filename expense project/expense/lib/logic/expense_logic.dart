import 'dart:convert';

import 'package:expense/model/category_model.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import '../model/expense_model.dart';

class ExpenseLogic extends ChangeNotifier {
  String _token = "";
    void setToken(String tok) {
    _token = tok;
  }
  Map<String, String> get headersCus => {
        "Authorization": "Bearer $_token",
      };
  void resetList() {
    listExp = [];
    notifyListeners();
  }

  List<Expense> listExp = [];
  List<Expense> get listOfexp => listExp;
  List<Expense> findExp(CategoryModel item) {
    List<Expense> result = [];
    listExp.forEach((element) {
      if (element.cid == item.cId) {
        result.add(element);
      }
    });
    return result;
  }

  String getTotalOfCat(CategoryModel item) {
    double resul = 0.0;
    listExp.forEach((element) {
      if (element.cid == item.cId) {
        resul += double.parse(element.ePrice);
      }
    });
    return resul.toString();
  }

  Future<bool> insertExp(Expense exp) async {
    try {
      String url = "http://10.0.2.2:3000/api/expense";
      print(exp);
      http.Response response = await http.post(Uri.parse(url),
          body: exp.toMap(), headers: headersCus);
      print(response.body);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["result"] ==
            "Expense Inserted Successful") {
          await readexp();
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  double getAllExpen() {
    double result = 0.0;
    listExp.forEach((element) {
      result += double.parse(element.ePrice);
    });
    return result;
  }

  Future<bool> editexp(Expense exp) async {
    try {
      String url = "http://10.0.2.2:3000/api/expense/${exp.eId}";
      http.Response response = await http.patch(Uri.parse(url),
          body: exp.toMap(), headers: headersCus);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        if (json.decode(response.body)["result"] ==
            "Expense Updated Successful") {
          await readexp();
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  Future<bool> deleteExp(Expense exp) async {
    try {
      String url = "http://10.0.2.2:3000/api/expense/${exp.eId}";
      http.Response response =
          await http.delete(Uri.parse(url), headers: headersCus);
      if (response.statusCode == 200) {
        if (json.decode(response.body)["result"] ==
            "Expense Deleted Successful") {
          await readexp();
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
    return false;
  }

  Future<void> readexp() async {
    try {
      String url = "http://10.0.2.2:3000/api/expense";
      http.Response response =
          await http.get(Uri.parse(url), headers: headersCus);
      if (response.statusCode == 200) {
        listExp = await compute(_convert, response.body);
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
  }
}

List<Expense> _convert(String body) {
  List list = json.decode(body);
  return list.map((e) => Expense.fromMap(e)).toList();
}
