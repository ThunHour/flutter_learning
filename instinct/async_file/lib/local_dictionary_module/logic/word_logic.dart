import 'package:async_file/local_dictionary_module/helpers/word_helpers.dart';
import 'package:async_file/local_dictionary_module/modals/word_modal.dart';
import 'package:flutter/cupertino.dart';

import '../content/wordListConstant.dart';

enum WordLoading {
  none,
  loading,
  error,
  done,
}

class WordLogic extends ChangeNotifier {
  List<WordModel> _wordModelList = [];
  List<WordModel> get wordModelListSortedByEnglish {
    _wordModelList.sort(((a, b) => a.english.compareTo(b.english)));
    return _wordModelList;
  }

  List<WordModel> get wordModelListtSortedByKhmer {
    _wordModelList.sort(((a, b) => a.khmer.compareTo(b.khmer)));
    return _wordModelList;
  }

  WordLoading _loading = WordLoading.none;
  WordLoading get loading => _loading;
  void setLoading() {
    _loading = WordLoading.loading;
    notifyListeners();
  }

  WordHelper _worldHelper = WordHelper();
  Future read() async {
    try {
      await _worldHelper.openDB();
      _wordModelList = await _worldHelper.selectAll();
      _loading = WordLoading.done;
    } catch (e) {
      _loading = WordLoading.error;
    }
    _wordModelList.sort(((a, b) => a.english.compareTo(b.english)));
    notifyListeners();
  }

  List<WordModel> _searchWordEnglish = [];
  List<WordModel> get searchwordEnglish {
    _searchWordEnglish.sort(((a, b) => a.english.compareTo(b.english)));
    return _searchWordEnglish;
  }

  List<WordModel> _searchWordKhmer = [];
  List<WordModel> get searchwordKhmer {
    _searchWordKhmer.sort(((a, b) => a.khmer.compareTo(b.khmer)));
    return _searchWordKhmer;
  }

  void clearSearchWord() {
    _searchWordKhmer = [];
    _searchWordEnglish = [];
    notifyListeners();
  }

  Future searchEnglish(String text) async {
    if (text.isEmpty || text == " " || text == "  ") {
      _searchWordEnglish = [];
    } else {
      _searchWordEnglish = await _worldHelper.searchEN(text);
      _searchWordEnglish.sort(((a, b) => a.english.compareTo(b.english)));
    }

    notifyListeners();
  }

  Future searchKhmer(String text) async {
    _searchWordKhmer = await _worldHelper.searchKH(text);
    _searchWordKhmer.sort(((a, b) => a.khmer.compareTo(b.khmer)));
    notifyListeners();
  }

  Future<WordModel> insert(WordModel item) {
    return _worldHelper.insert(item);
  }

  Future<int> delete(WordModel item) {
    return _worldHelper.delete(item.id);
  }

  Future<int> update(WordModel item) {
    return _worldHelper.update(item);
  }

  WordLoading _resetDataLoading = WordLoading.none;
  WordLoading get loadingData => _resetDataLoading;
  void setResetLoading() {
    _resetDataLoading = WordLoading.loading;
    notifyListeners();
  }

  Future resetData() async {
    await eraseAllRecords();
    for (WordModel item in wordListConstant) {
      await _worldHelper.insert(item);
    }
    _resetDataLoading = WordLoading.done;
    notifyListeners();
  }

  Future eraseAllRecords() async {
    _worldHelper.eraseAllRecord();
    read();
  }
}
