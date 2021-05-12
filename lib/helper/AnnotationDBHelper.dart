import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manipulando_dados/model/Annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnnotationDBHelper {
  static final AnnotationDBHelper _instance = AnnotationDBHelper._internal();
  Database _db;
  static final String tableAnnotation = "anotacao_table";

  AnnotationDBHelper._internal();

  // singleton
  factory AnnotationDBHelper() => _instance;

  // init data base
  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDB();
      return _db;
    }
  }

  _initDB() async {
    final pathDB = await getDatabasesPath();
    final localDB = join(pathDB, "data_base_annotation.db");

    var db = await openDatabase(localDB, version: 1, onCreate: _createDB);

    return db;
  }

  _createDB(Database db, int version) {
    String sql = " CREATE TABLE $tableAnnotation "
        "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "title VARCHAR, "
        "description TEXT, "
        "date DATETIME)";
    db.execute(sql);
  }

  // operation crud
  Future<int> save(Annotation annotation) async {
    final Database dataBase = await db;
    return await dataBase.insert(tableAnnotation, annotation.toMap());
  }

  list() async {
    final Database dataBase = await db;
    String sql = "SELECT * FROM $tableAnnotation ORDER BY date desc";
    List rawQuery = await dataBase.rawQuery(sql);

    return rawQuery;
  }

  Future<int> update(Annotation annotation) async {
    final Database dataBase = await db;
    return await dataBase.update(
        tableAnnotation,
        annotation.toMap(),
        where: "id = ?",
        whereArgs: [annotation.id]);
  }

  Future<int> delete(int id) async {
    final Database dataBase = await db;
    return await dataBase.delete(
        tableAnnotation,
        where: "id = ?",
        whereArgs: [id]);
  }


}
