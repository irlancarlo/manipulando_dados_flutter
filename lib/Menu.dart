import 'package:flutter/material.dart';
import 'package:manipulando_dados/DataBaseComplete.dart';
import 'package:manipulando_dados/DataBaseSimple.dart';
import 'package:manipulando_dados/ReadWriteInFile.dart';
import 'package:manipulando_dados/UsingSharedPreferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void _openSharedPreferences() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UsingSharedPreferences()));
  }

  void _openSystemFileWithFAB() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReadWriteInFile()));
  }

  void _openDataBaseSimple() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DataBaseSimple()));
  }

  void _openDataBaseComplete() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DataBaseComplete()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manipulação de dados")),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemMenuSharedPreferences(
                "Usando Shared Preferences", _openSharedPreferences),
            itemMenuSharedPreferences(
                "Usando Sistema de Arquivos", _openSystemFileWithFAB),
            itemMenuSharedPreferences(
                "Banco de Dados (simples)", _openDataBaseSimple),
            itemMenuSharedPreferences(
                "Banco de Dados (completo)", _openDataBaseComplete),
          ],
        ),
      ),
    );
  }

  GestureDetector itemMenuSharedPreferences(
      String nameMenu, void Function() openScreen) {
    return GestureDetector(
        onTap: openScreen,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            nameMenu,
            style: TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid),
          ),
        ));
  }
}
