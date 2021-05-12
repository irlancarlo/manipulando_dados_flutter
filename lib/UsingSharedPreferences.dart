import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsingSharedPreferences extends StatefulWidget {
  @override
  _UsingSharedPreferencesState createState() => _UsingSharedPreferencesState();
}

class _UsingSharedPreferencesState extends State<UsingSharedPreferences> {
  TextEditingController _constrollerInput = TextEditingController();
  String _textSaved = "Texto salvo";

  void _save() async {
    String valueSaved = _constrollerInput.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valueSaved);
  }

  void _read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textSaved = prefs.getString("nome") ?? "Sem valor";
    });
  }

  void _remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shared Preferences")),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Center(
                child: Text(
              _textSaved,
              style: TextStyle(fontSize: 20),
            )),
            TextField(
              keyboardType: TextInputType.text,
              controller: _constrollerInput,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Digite algo'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _save,
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(color: Colors.black))),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    child: Text(
                      "Salvar",
                      style: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: _read,
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(color: Colors.black))),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    child: Text(
                      "Ler",
                      style: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: _remove,
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(color: Colors.black))),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15))),
                    child: Text(
                      "Remover",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
