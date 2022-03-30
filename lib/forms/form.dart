// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, use_key_in_widget_constructors, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController ageController;

  AppForm({
    required this.formKey,
    required this.nameController,
    required this.ageController,
  });

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  String? _validateName(String? value) {
    if (value!.length < 8) return 'Name must be at least 8 characters';
    return null;
  }

  String? _validateAge(String? value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regExp = RegExp(pattern.toString());
    if (!regExp.hasMatch(value!)) return 'Age must be number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Enter your name'),
            validator: _validateName,
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
          ),
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter your age'),
            validator: _validateAge,
          ),
        ],
      ),
    );
  }
}
