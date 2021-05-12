import 'package:flutter/material.dart';
import 'package:manipulando_dados/helper/AnnotationDBHelper.dart';
import 'package:manipulando_dados/helper/DateHelper.dart';
import 'package:manipulando_dados/model/Annotation.dart';

class DataBaseComplete extends StatefulWidget {
  @override
  _DataBaseCompleteState createState() => _DataBaseCompleteState();
}

class _DataBaseCompleteState extends State<DataBaseComplete> {
  TextEditingController _titleTextFieldController = TextEditingController();
  TextEditingController _descriptionTextFieldController =
      TextEditingController();
  AnnotationDBHelper db = AnnotationDBHelper();

  List<Annotation> _annotations = [];

  _openForm({Annotation annotation}) {
    String textSaveEdit;
    if (annotation == null) {
      textSaveEdit = "Salvar";
      _titleTextFieldController.clear();
      _descriptionTextFieldController.clear();
    } else {
      textSaveEdit = "Alterar";
      _titleTextFieldController.text = annotation.title;
      _descriptionTextFieldController.text = annotation.description;
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textSaveEdit anotação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  controller: _titleTextFieldController,
                  decoration: InputDecoration(
                      labelText: "Título", hintText: "Digite o título..."),
                ),
                TextField(
                  controller: _descriptionTextFieldController,
                  decoration: InputDecoration(
                      labelText: "Descrição",
                      hintText: "Digite a descrição..."),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _saveUpdateAnnotation(annotationSelected: annotation);
                  },
                  child: Text(textSaveEdit)),
            ],
          );
        });
  }

  _saveUpdateAnnotation({Annotation annotationSelected}) async {
    String title = _titleTextFieldController.text;
    String description = _descriptionTextFieldController.text;
    if (annotationSelected == null) {
      //save
      Annotation annotation =
          Annotation(title, description, DateTime.now().toString());

      int save = await db.save(annotation);
      print("Anotacacao save: " + save.toString());
    } else {
      //update
      annotationSelected.title = title;
      annotationSelected.description = description;
      annotationSelected.date = DateTime.now().toString();

      await db.update(annotationSelected);
    }

    _titleTextFieldController.clear();
    _descriptionTextFieldController.clear();
    _listAnnotation();
  }

  void _listAnnotation() async {
    List<Annotation> annotationTempList = [];
    List list = await db.list();

    for (var item in list) {
      Annotation annotation = Annotation.fromMap(item);
      annotationTempList.add(annotation);
    }

    setState(() {
      _annotations = annotationTempList;
    });
    annotationTempList = null;

    print("Anotacacao list: " + _annotations.toString());
  }

  void _delete(int id) async {
    await db.delete(id);
    _listAnnotation();
  }

  @override
  void initState() {
    super.initState();
    _listAnnotation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banco de dados completo"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _annotations.length,
                  itemBuilder: (context, index) {
                    Annotation annotation = _annotations[index];

                    return Card(
                      child: ListTile(
                        title: Text(annotation.title),
                        subtitle: Text(
                            "${DateHelper.formatDate(annotation.date)} - ${annotation.description}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              onTap: () {
                                _openForm(annotation: annotation);
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                _delete(annotation.id);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _openForm,
      ),
    );
  }
}
