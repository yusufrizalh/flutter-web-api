// ignore_for_file: prefer_const_constructors_in_immutables, unused_import, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_api/base_url.dart';
import 'package:flutter_web_api/forms/form.dart';

class Create extends StatefulWidget {
  final Function? refreshStudentList;

  Create({this.refreshStudentList});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future _createStudent() async {
    final url = '${BaseUrl.BASE_URL}/create.php';
    return await http.post(
      Uri.parse(url),
      body: {
        "name": nameController.text,
        "age": ageController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Student'),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              ageController: ageController,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              _onConfirmSave(context);
            }
          },
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onConfirmSave(context) async {
    await _createStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
