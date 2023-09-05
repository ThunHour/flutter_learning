import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileLogic extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  Future readdata() async{
    _counter = await _readCounter();
  }
  void increase() async {
    _counter++;
    _writeCounter(_counter);
    notifyListeners(); 
  }  void decrease() async {
    _counter--;
    _writeCounter(_counter);
    notifyListeners(); 
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> _writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }

  Future<int> _readCounter() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      return int.parse(content);
    } catch (e) {
      return 0;
    }
  }
}
