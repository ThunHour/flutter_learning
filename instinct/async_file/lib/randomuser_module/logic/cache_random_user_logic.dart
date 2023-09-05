import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:http/http.dart" as http;

import 'package:flutter/foundation.dart';
import '../model/random_user_model.dart';

enum Status { none, loading, success, error }

class CacheRamdomLogic extends ChangeNotifier {
  final int resultNumPerPage = 40;
  RandomUserModel _randomUserModel = RandomUserModel(info: Info());
  bool _hasInternet = false;
  bool get hasInternest => _hasInternet;

  Status _status = Status.none;
  List<Result> _resultList = [];
  List<Result> get result => _resultList;
  List<Result> _resultAllData = [];
  List<Result> get getAllData => _resultAllData;

  Status get statue => _status;
  int get Index => _page;
  void setLoading() {
    _status = Status.loading;
    notifyListeners();
  }

  int _page = 0;

  Future readMore({required bool refresh}) async {
    String body = "";
    if (refresh) {
      _page = 0;
    }
    _page++;
    if (_page > 100) _page = 1;
    try {
      String url =
          "https://randomuser.me/api?results=$resultNumPerPage&page=$_page";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        body = response.body;
        if (refresh) {
          _randomUserModel = await compute(_convert, response.body);
          _resultList = _randomUserModel.results;
        } else {
          RandomUserModel local =
              _randomUserModel = await compute(_convert, response.body);
          _resultList += local.results;
        }
        _status = Status.success;
        _hasInternet = true;
      } else {
        print("Error while reading data, status code: ${response.statusCode}");
        _status = Status.error;
        _hasInternet = false;
      }
    } catch (e) {
      print("Error ${e.toString()}");
      _status = Status.error;
      _hasInternet = false;
    }

    if (_hasInternet) {
      _write(body);
    } else {
      String? cache = await _read();
      if (cache != null) {
        _randomUserModel = await compute(_convert, cache);
        _resultList = _randomUserModel.results;
        _status = Status.success;
      } else {
        _status = Status.error;
      }
    }
    notifyListeners();
  }

  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final String _key = "randomUserKey";

  void _write(String value) {
    _secureStorage.write(key: _key, value: value);
  }

  Future<String?> _read() async {
    String? data = await _secureStorage.read(key: _key);
    return data;
  }

  void removeItem(Result item) {
    _resultList.remove(item);
    notifyListeners();
  }

  void copyItem(Result item) {
    final index =
        _resultList.indexWhere((singleElement) => singleElement.id == item.id);
    _resultList.insert(index, item);
    notifyListeners();
  }

  List<Result> _listFavorite = [];
  List<Result> get favorite => _listFavorite;
  void addFavorite(Result item) {
    _listFavorite.add(item);
    notifyListeners();
  }

  void removeFavorite(Result item) {
    _listFavorite.remove(item);
    notifyListeners();
  }

  void clearAllFavoite() {
    _listFavorite = [];
    notifyListeners();
  }

  bool isFavorite(Result item) {
    return _listFavorite.contains(item);
  }

  bool hasFavorite() {
    return _listFavorite.isNotEmpty;
  }
}

RandomUserModel _convert(String body) {
  // Map<String,dynamic> map = json.decode(body);
  return RandomUserModel.fromMap(json.decode(body));
}
