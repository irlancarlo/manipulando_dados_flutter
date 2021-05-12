class Annotation {
  int _id;
  String _title;
  String _description;
  String _date;

  Annotation(this._title, this._description, this._date);

  Annotation.fromMap(Map map){
    _id = map["id"];
    _title = map["title"];
    _description = map["description"];
    _date = map["date"];
  }

  Map toMap(){
    Map<String, dynamic> values = {
      "title": this._title,
      "description": this._description,
      "date": this._date,
    };

    if(_id != null){
      values["id"] = this._id;
    }

    return values;
  }

  String get date => _date;

  String get description => _description;

  String get title => _title;

  int get id => _id;

  set date(String value) {
    _date = value;
  }

  set description(String value) {
    _description = value;
  }

  set title(String value) {
    _title = value;
  }
}