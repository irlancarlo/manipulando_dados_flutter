import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseSimple extends StatefulWidget {
  @override
  _DataBaseSimpleState createState() => _DataBaseSimpleState();
}

class _DataBaseSimpleState extends State<DataBaseSimple> {
  static const String TABLE_USER = "user";

  _initDataBase() async {
    final dataBasePath = await getDatabasesPath();
    final localDataBase = join(dataBasePath, "base.bd");

    Database dataBase = await openDatabase(
      localDataBase,
      version: 1,
      onCreate: (db, version) {
        String sql = " CREATE TABLE $TABLE_USER "
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name VARCHAR, "
            "age INTEGER ) ";
        db.execute(sql);
      },
    );

    return dataBase;
  }

  _save() async {
    Database db = await _initDataBase();

    Map<String, dynamic> values = {"name": "joao", "age": 2};
    int insert = await db.insert(TABLE_USER, values);
    print("salvo: $insert");
  }

  _list() async {
    Database db = await _initDataBase();

    String sql = " SELECT * FROM $TABLE_USER ";
    var list = await db.rawQuery(sql);
    for (var user in list) {
      print("id: " + user["id"].toString());
      print("name: " + user["name"]);
      print("age: " + user["age"].toString());
      print("------------");
    }
  }

  _findById(int id) async {
    Database db = await _initDataBase();
    List users = await db.query(TABLE_USER,
        columns: ["id", "name", "age"], where: "id = ?", whereArgs: [id]);

    for (var user in users) {
      print("x------------x");
      print("id: " + user["id"].toString());
      print("name: " + user["name"]);
      print("age: " + user["age"].toString());
    }
  }

  _delete(int id) async {
    Database db = await _initDataBase();
    int result = await db.delete(TABLE_USER, where: "id = ?", whereArgs: [id]);

    print("Item removido: " + result.toString());
  }

  _update(int id) async {
    Database db = await _initDataBase();

    Map<String, dynamic> values = {"name": "bento", "age": 2};
    int result =
        await db.update(TABLE_USER, values, where: "id = ?", whereArgs: [id]);

    print("Item atualizado: " + result.toString());
  }

  @override
  Widget build(BuildContext context) {
    // _initDataBase();
    // _save();
    // _list();
    //_findById(7);
    //_delete(7);
    // _list();
    // _update(4);
    // _list();
    return Container();
  }
}
