class Note {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Note(this._title, this._priority, this._date, [this._description]);
  Note.withId(this._id, this._title, this._priority, this._date,
      [this._description]);

// all getters
  int get id => this._id;
  String get title => this._title;
  String get description => this._description;
  int get priority => this._priority;
  String get date => this._date;

  // all setters
  set title(String title) {
    if (title.length <= 255) {
      this._title = title;
    }
  }

  set description(String description) {
    if (description.length <= 255) {
      this._description = description;
    }
  }

  set date(String date) {
    this._date = date;
  }

  set priority(int priority) {
    if (priority >= 1 && priority <= 2) this._priority = priority;
  }

// a method to convert to map object
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this._id != null) {
      // if _id is null then insert the note or update the note
      map['id'] = this._id;
    }
    map['title'] = this._title;
    map['description'] = this._description;
    map['date'] = this.date;
    map['priority'] = this._priority;

    return map;
  }

// named constructor to extract from map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}
