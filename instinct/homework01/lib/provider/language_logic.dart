import 'package:flutter/foundation.dart';
import '../stateManagement-pages/Constant/language.dart';
class LanguageLogic extends ChangeNotifier{
  Language _language=Language();
  Language get language=>_language;
  int _index=0;
  void toggleLanguage(){
    _index++;
    if(_index>=languageList.length) {
      _index = 0;
    }
    _language=languageList[_index];
    notifyListeners();
  }
}