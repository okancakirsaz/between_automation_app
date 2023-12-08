import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class LocaleSqlManager {
  static LocaleSqlManager instance = LocaleSqlManager();
  late Database _instance;
  Future<void> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/between_locale_datas.db";
    _instance = sqlite3.open(path);
    debugPrint(path);
    try {
      createColumns();
    } catch (e) {
      //The columns already exist
    }
  }

  createColumns() {
    _instance.execute('''CREATE TABLE stock(
      name TEXT,
      cost INTEGER,
      count INTEGER,
      unit TEXT,
      currency TEXT,
      prefferedCount INTEGER
    )''');

    _instance.execute('''CREATE TABLE menu(
      name TEXT,
      img BLOB,
      materials TEXT,
      price INTEGER
    )''');
  }

  setValue(
      {required String tableName,
      required List<String> keys,
      required List<dynamic> values}) {
    String kys = keys.join(", ");
    String valueCount = "?, " * values.length;
    final PreparedStatement query = _instance.prepare(
        "INSERT INTO $tableName ($kys) VALUES (${valueCount.substring(0, valueCount.length - 2)})");
    query.execute(values);
  }

  List<dynamic>? getTable(String tableName) {
    final query = _instance.select("SELECT * FROM $tableName");
    return query.toList();
  }

  editValue({
    required String tableName,
    required String comparedValue,
    required List<String> keys,
    required String whereParam,
    required List<dynamic> values,
  }) {
    String parsedKeys = keys.join(" = ?,");
    final PreparedStatement query = _instance.prepare(
        "UPDATE $tableName SET $parsedKeys=? WHERE $whereParam = '$comparedValue'");
    query.execute(values);
  }

  deleteValue(String tableName, String key, String comparedValue) {
    _instance.execute("DELETE FROM '$tableName' WHERE $key='$comparedValue'");
  }

  getStringValue(String tableName, String columnName, String value) {
    final query = _instance
        .select("SELECT * FROM $tableName WHERE $columnName = '$value'");
    return query.toList();
  }

  getDynamicValue(String tableName, String columnName, dynamic value) {
    final query =
        _instance.select("SELECT * FROM $tableName WHERE $columnName = $value");
    return query.toList();
  }
}
