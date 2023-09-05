import 'package:flutter/cupertino.dart';

class Token extends ChangeNotifier {
  String _token = "";

  String get JwtToken => _token;
  void setToken(String token) {
    this._token = token;
    notifyListeners();
  }
}
