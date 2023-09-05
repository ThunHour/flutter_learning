import 'dart:convert';
import "package:http/http.dart" as http;

import 'package:flutter/foundation.dart';
import '../constant/status-eum.dart';
import '../model/postmodel.dart';

class PostLogic extends ChangeNotifier {
  List<PostModel> _photoList = [];

  List<PostModel> get photolist => _photoList;

  Status _status = Status.none;

  Status get statue => _status;
  int get Index => _userId;
  void setLoading() {
    _status = Status.loading;
    notifyListeners();
  }

  int _userId = 0;

  Future readMore(bool refresh) async {
    if (refresh) {
      _userId = 0;
    }
    _userId++;
    if (_userId > 10) _userId = 1;

    try {
      String url = "https://jsonplaceholder.typicode.com/posts?userId=$_userId";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<PostModel> newItem = await compute(_convert, response.body);
        if (refresh) {
          _photoList = newItem;
        } else {
          _photoList += newItem;
        }

        _status = Status.success;
      } else {
        print("Error while reading data, status code: ${response.statusCode}");
        _status = Status.error;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      _status = Status.error;
    }
    notifyListeners();
  }
  // Future read() async {
  //   _userId++;
  //   if (_userId > 10) _userId = 1;

  //   try {
  //     String url = "https://jsonplaceholder.typicode.com/posts?userId=$_userId";
  //     http.Response response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       _photoList = await compute(_convert, response.body);
  //       _status = Status.success;
  //     } else {
  //       print("Error while reading data, status code: ${response.statusCode}");
  //       _status = Status.error;
  //     }
  //   } catch (e) {
  //     print("Error ${e.toString()}");
  //     _status = Status.error;
  //   }
  //   notifyListeners();
  // }
}

List<PostModel> _convert(String body) {
  List list = json.decode(body);
  return list.map((item) => PostModel.fromMap(item)).toList();
}
