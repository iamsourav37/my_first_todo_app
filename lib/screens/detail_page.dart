import 'dart:developer';

import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String title;
  DetailPage(this.title);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> _priorities = ['High', 'Low'];
  String dropDownItemValue = 'Low';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          widget.title,
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
            DropdownButton(
              value: dropDownItemValue,
              isExpanded: true,
              underline: Container(
                height: 2.2,
                color: Colors.black,
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
              onChanged: (newValue) {
                setState(() {
                  this.dropDownItemValue = newValue;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (newValue) {},
                controller: _titleController,
                style: TextStyle(
                  fontSize: 26.0,
                ),
                decoration: InputDecoration(
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
                onChanged: (newValue) {},
                controller: _descriptionController,
                style: TextStyle(
                  fontSize: 26.0,
                ),
                decoration: InputDecoration(
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
