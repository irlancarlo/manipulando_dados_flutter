import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class ReadWriteInFile extends StatefulWidget {
  @override
  _ReadWriteInFileState createState() => _ReadWriteInFileState();
}

class _ReadWriteInFileState extends State<ReadWriteInFile> {
  List _taskList = [];
  TextEditingController _inputTaskController = TextEditingController();
  Map<String, dynamic> _lastTaskRemoved = Map();

  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  _saveTask() {
    Map<String, dynamic> task = Map();
    task["title"] = _inputTaskController.text;
    task["status"] = false;
    setState(() {
      _taskList.add(task);
    });
    _saveFile();
    _inputTaskController.text = "";
  }

  _saveFile() async {
    var file = await _initFile();
    var data = jsonEncode(_taskList);
    file.writeAsString(data);
  }

  Future _readFile() async {
    try {
      File file = await _initFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _readFile().then((value) {
      setState(() {
        _taskList = jsonDecode(value);
      });
    });
  }

  Widget _createListItem(context, index) {
    // all keys must be different
    final key = DateTime.now().microsecondsSinceEpoch.toString();

    return Dismissible(
        key: Key(key),
        direction: DismissDirection.endToStart,
        onDismissed: (dismiss) {
          _lastTaskRemoved = _taskList[index];
          _taskList.removeAt(index);
          _saveFile();

          final snackBar = SnackBar(
            content: Text("Item removido!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              textColor: Colors.black,
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _taskList.insert(index, _lastTaskRemoved);
                });
                _saveFile();
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        background: Container(
          padding: EdgeInsets.all(16),
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        child: CheckboxListTile(
            title: Text(_taskList[index]["title"]),
            value: _taskList[index]["status"],
            onChanged: (valueChanged) {
              setState(() {
                _taskList[index]["status"] = valueChanged;
              });
              _saveFile();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usando Sistema de Arquivos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _taskList.length, itemBuilder: _createListItem),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // floatingActionButton: FloatingActionButton.extended(
        //   icon: Icon(Icons.add_shopping_cart),
        //   label: Text("Adicionar"),
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(50)
        // ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Adicionar tarefa"),
                  content: TextField(
                    controller: _inputTaskController,
                    decoration: InputDecoration(labelText: "Digite uma tarefa"),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancelar")),
                    ElevatedButton(
                        onPressed: () {
                          _saveTask();
                          Navigator.pop(context);
                        },
                        child: Text("Salvar")),
                  ],
                );
              });
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   // shape: CircularNotchedRectangle(),
      //   child: Row(
      //     children: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      //   ),
      // ),
    );
  }
}
