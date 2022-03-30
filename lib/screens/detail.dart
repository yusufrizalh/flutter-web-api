// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_api/base_url.dart';
import 'package:flutter_web_api/models/students.dart';
import 'package:flutter_web_api/screens/edit.dart';

class Detail extends StatefulWidget {
  Detail({required this.students});

  final Students students;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: Icon(Icons.remove_circle),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 270.0,
          padding: EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name: ${widget.students.name}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
              ),
              Text(
                'Age: ${widget.students.age}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit_note),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(students: widget.students),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure want to delete?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel_presentation),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
            ),
            ElevatedButton(
              onPressed: () => _deleteStudent(context),
              child: Icon(Icons.check_box_sharp),
              style: ElevatedButton.styleFrom(primary: Colors.orange),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(context) async {
    final url = '${BaseUrl.BASE_URL}/delete.php';
    await http.post(Uri.parse(url), body: {
      'id': widget.students.id.toString(),
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
