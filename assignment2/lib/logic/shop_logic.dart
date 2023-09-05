import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/foundation.dart';

import '../model/shop.dart';

class ShopLogic extends ChangeNotifier {
  List<ShopModel> mainData = [];
  List<ShopModel> get MainData => mainData;
  List<ShopModel> buyList = [];
  List<ShopModel> get BuyList => buyList;
  List<ShopModel> _displayData = [];
  List<ShopModel> get DisplayDataList => _displayData;

  Future readData({refresh = false}) async {
    try {
      String url = "https://fakestoreapi.com/products";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<ShopModel> newItems = await compute(convert, response.body);
        mainData = newItems;
        _displayData = newItems;
      }
    } catch (e) {
      print("Error ${e.toString()}");
    }
    notifyListeners();
  }

  getAllcategoty() {
    List res = [];
    mainData.forEach((element) {
      if (!res.contains(element.category)) {
        res.add(element.category);
      }
    });
    return res;
  }

  addToCart(ShopModel item) {
    if (!buyList.contains(item)) {
      buyList.add(item);
    } else {
      final int index = buyList.indexWhere(((book) => book.id == item.id));
      buyList[index].amount += 1;
    }
    notifyListeners();
  }

  double sunTotal() {
    double temp = 0;
    for (int i = 0; i < buyList.length; i++) {
      temp += buyList[i].price * buyList[i].amount;
    }
    return temp;
  }

  deleteFromCart(ShopModel item) {
    if (item.amount == 1) {
      buyList.remove(item);
    } else if (item.amount > 1) {
      final int index = buyList.indexWhere(((book) => book.id == item.id));
      buyList[index].amount -= 1;
    }
    notifyListeners();
  }

  buy() {
    buyList = [];
  }

  count(ShopModel item) {
    if (buyList.contains(item)) {
      final int index = buyList.indexWhere(((book) => book.id == item.id));
      return buyList[index].amount;
    } else {
      return 1;
    }
  }

  displayByCategoty(String type) {
    List<ShopModel> res = [];
    mainData.forEach((element) {
      if (element.category == type) {
        res.add(element);
      }
    });
    _displayData = res;
    notifyListeners();
  }

  resetData() {
    _displayData = mainData;
    notifyListeners();
  }
}

List<ShopModel> convert(String body) {
  List list = json.decode(body);
  return list.map((e) => ShopModel.fromMap(e)).toList();
}
