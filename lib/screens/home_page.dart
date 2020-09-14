import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import '../model/database_helper.dart';
import '../model/note.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  navigateToDetailPage(Note note) async {
    log("navigate to detail screen with data");
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage("Edit Todo", note),
        // when we update a todo or note we send the data
      ),
    );

    if (result == true) {
      // update the view
      this.updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = _databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = _databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          log("from updateListView, noteList : $noteList");
          log("from updateListView, count : $count");
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Todos",
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to the detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailPage("Add Todo", Note('', 2, '', ''));
                // when we add a new todo or note its blank initially, and give priority as your choice for dropdown
              },
            ),
          );
          this.updateListView();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 50.0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5.0),
        child: ListView.builder(
          itemCount: this.count,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              color: Colors.grey[200],
              child: Container(
                height: 70.0,
                child: ListTile(
                  onTap: () {
                    // navigate to detail screen with data
                    navigateToDetailPage(noteList[i]);
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.low_priority),
                  ),
                  title: Text(noteList[i].title),
                  subtitle: Text(noteList[i].date),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      log("Delete button pressed");
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
