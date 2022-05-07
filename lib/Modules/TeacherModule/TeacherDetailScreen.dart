/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'TeacherModel.dart';
import 'TeacherAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class TeacherDetailScreen extends StatefulWidget {
  final TeacherModel teacherModel;

  const TeacherDetailScreen({Key? key, required this.teacherModel}) : super(key: key);

  @override
  _TeacherDetailScreenState createState() => _TeacherDetailScreenState();
}

class _TeacherDetailScreenState extends State<TeacherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.PT_TEACHER),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteTeacherModel();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeacherAddEditScreen(
                  compartmentModel: widget.teacherModel,
                ),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            widget.teacherModel.name,
            style: TextStyle(color: Colors.blue.shade50, fontSize: 24),
          ),
        ),
      )),
    );
  }

  Future _deleteTeacherModel() async {
    await DatabaseHelper.db.deleteTeacher(widget.teacherModel);
  }
}
