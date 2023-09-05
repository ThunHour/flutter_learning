import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreLogic extends ChangeNotifier {
  bool _dark = false;
  bool get dark => _dark;

  Future readTeme() async {
    _dark = await _read();
    notifyListeners();
  }

  void toggleTheme() {
    _dark = !_dark;
    _write(_dark);
    notifyListeners();
  }

  final _key = "ThemeKey";
  Future _write(bool theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(_key, theme);
  }

  Future _read() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(_key) ?? false;
  }
}
