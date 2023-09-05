import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCache extends ChangeNotifier {
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final String _darkkey = "dark";
  bool _dark = false;
  bool get dark => _dark;
  Future readTheme() async {
    _dark = await read();
    notifyListeners();
  }

  void switchTheme() {
    _dark = !_dark;
    write(_dark);
    notifyListeners();
  }

  void write(bool value) {
    _secureStorage.write(key: _darkkey, value: value.toString());
  }

  Future<bool> read() async {
    String? data = await _secureStorage.read(key: _darkkey);
    return data == "true" ? true : false;
  }
}
