// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, dead_code, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_web_api/base_url.dart';
import 'package:flutter_web_api/models/students.dart';
import 'package:flutter_web_api/screens/create.dart';
import 'package:flutter_web_api/screens/detail.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Students>> students;
  final studentListKey = GlobalKey<_HomeState>();

  // menampilkan semua data diawal
  @override
  void initState() {
    super.initState();
    students = getStudentsList();
  }

  Future<List<Students>> getStudentsList() async {
    final url = '${BaseUrl.BASE_URL}/list.php';
    final response = await http.get(Uri.parse(url));

    final items =
        convert.json.decode(response.body).cast<Map<String, dynamic>>();
    List<Students> students = items.map<Students>((json) {
      return Students.fromJson(json);
    }).toList();
    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Center(
        child: FutureBuilder(
          future: students,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // memunculkan loading
            if (!snapshot.hasData) return CircularProgressIndicator();
            // ada data ditemukan maka ditampilkan
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int position) {
                var data = snapshot.data[position];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.orange[900]),
                    trailing: Icon(Icons.list, color: Colors.orange[900]),
                    title: Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.orange[900],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      print(data.name.toString() + ", " + data.age.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(students: data),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('Add Student');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => Create(),
            ),
          );
        },
      ),
    );
  }
}
