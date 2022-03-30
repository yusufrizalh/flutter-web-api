// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_api/base_url.dart';
import 'package:flutter_web_api/models/students.dart';
import 'package:flutter_web_api/forms/form.dart';

class Edit extends StatefulWidget {
  final Students students;

  Edit({required this.students});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController ageController;

  Future _editStudent() async {
    final url = '${BaseUrl.BASE_URL}/update.php';
    return await http.post(Uri.parse(url), body: {
      'id': widget.students.id.toString(),
      'name': nameController.text,
      'age': ageController.text,
    });
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.students.name);
    ageController = TextEditingController(text: widget.students.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
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
              _onConfirmUpdate(context);
            }
          },
          child: Text(
            'Update',
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

  void _onConfirmUpdate(context) async {
    await _editStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
