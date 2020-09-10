import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
          log("add button clicked");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailPage();
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 50.0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Container(
                height: 70.0,
                child: InkWell(
                  splashColor: Colors.grey[50],
                  onTap: () {
                    log("tapped");
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.priority_high),
                    ),
                    title: Text("My todo app $i"),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
