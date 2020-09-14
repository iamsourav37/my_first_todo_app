import 'dart:developer';
import '../model/note.dart';
import '../model/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final Note note;
  DetailPage(this.title, this.note);
  @override
  _DetailPageState createState() => _DetailPageState(this.note, this.title);
}

class _DetailPageState extends State<DetailPage> {
  final String title;
  final Note note;
  static List<String> _priorities = ['High', 'Low'];
  String dropDownItemValue = 'Low';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  _DetailPageState(this.note, this.title); // constructor

  updateTitle() {
    note.title = _titleController.text;
  }

  updateDescription() {
    note.description = _descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;

    if (note.id == null) {
      // new todo, insert it
      result = await _databaseHelper.insertNote(note);
      log("_save , result : $result");
      if (result != 0) {
        _showMyDialog(
            "Status", "Insert successfully !!!", Colors.greenAccent[400]);
      } else {
        _showMyDialog("Status", "Insert failed !!!", Colors.redAccent[700]);
      }
    } else {
      // id is already there
      //it means existing todo , update it
      result = await _databaseHelper.updateNote(note);
      if (result != 0) {
        _showMyDialog(
            "Status", "Update successfully !!!", Colors.greenAccent[400]);
      } else {
        _showMyDialog("Status", "Update failed !!!", Colors.redAccent[700]);
      }
    }
  }

  void _delete() async {
    moveToLastScreen();
    if (note.id == null) {
      _showMyDialog("Status", "Nothing to delete", Colors.indigoAccent);
      return;
    }
    int result = await _databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showMyDialog(
          "Status", "Delete Successfully !!!", Colors.greenAccent[400]);
    } else {
      _showMyDialog("Status", "Delete failed !!!", Colors.redAccent[700]);
    }
  }

// for priority , converting to int to save in the database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
    log("from updatePriorityAsInt , priority : ${note.priority}");
  }

// to display , converting priority int to string
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    log("from getPriorityAsString , priority : $priority");

    return priority;
  }

  moveToLastScreen() {
    Navigator.pop(context, true);
  }

  _showMyDialog(String title, String msg, Color color) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          content: Text(
            msg,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.yellowAccent,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = note.title;
    _descriptionController.text = note.description;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          this.title,
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.low_priority),
              title: DropdownButton(
                value: getPriorityAsString(note.priority),
                onChanged: (newValue) {
                  setState(() {
                    updatePriorityAsInt(newValue);
                  });
                },
                isExpanded: true,
                underline: Container(
                  height: 2.2,
                  color: Colors.lightBlue,
                ),
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                items: _priorities
                    .map(
                      (String dropDownStringItem) => DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (newValue) {
                  updateTitle();
                },
                controller: _titleController,
                style: TextStyle(
                  fontSize: 26.0,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (newValue) {
                  updateDescription();
                },
                controller: _descriptionController,
                style: TextStyle(
                  fontSize: 26.0,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.details),
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      elevation: 6.4,
                      onPressed: () {
                        log("Saved button clicked");
                        setState(() {
                          _save();
                        });
                      },
                      color: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: RaisedButton(
                      elevation: 6.4,
                      onPressed: () {
                        log("Delete button clicked");
                        setState(() {
                          _delete();
                        });
                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
