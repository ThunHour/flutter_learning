import 'package:async_file/local_dictionary_module/modals/word_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WordHelper {
  late Database db;
  Future openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    db =
        await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnEnglish TEXT NOT NULL,
            $columnKhmer TEXT NOT NULL
     ) ''');
  }

  Future<WordModel> insert(WordModel wordmodel) async {
    wordmodel.id = await db.insert(tableName, wordmodel.toMap);
    return wordmodel;
  }

  Future<int> update(WordModel wordModel) async {
    return await db.update(
      tableName,
      wordModel.toMap,
      where: '$columnId=?',
      whereArgs: [wordModel.id],
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> eraseAllRecord() async {
    return await db.delete(
      tableName,
    );
  }

  Future<List<WordModel>> selectAll() async {
    List list = await db.query(tableName);
    return compute(_parseData, list);
  }

  Future<List<WordModel>> searchEN(String text) async {
    List list = await db
        .query(tableName, where: '$columnEnglish LIKE ?', whereArgs: ['%$text%']);
    return compute(_parseData, list);
  }  Future<List<WordModel>> searchKH(String text) async {
    List list = await db
        .query(tableName, where: '$columnKhmer LIKE ?', whereArgs: ['%$text%']);
    return compute(_parseData, list);
  }

  Future close() async => db.close();

  Future<List<WordModel>> rawQuery(String sql) async {
    List list = await db.rawQuery(sql);
    return compute(_parseData, list);
  }
}

List<WordModel> _parseData(List list) {
  return list.map((e) => WordModel.fromMap(e)).toList();
}
