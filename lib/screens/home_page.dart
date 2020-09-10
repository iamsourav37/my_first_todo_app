import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My TODO"),
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text("My todo app $i"),
              trailing: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
