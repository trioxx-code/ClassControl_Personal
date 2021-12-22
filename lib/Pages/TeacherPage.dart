/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<TeacherModel> teachers = [];
  bool isLoading = false;

  TextEditingController _teacher = new TextEditingController();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    _teacher.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    //teachers = await DatabaseHelper.db.getAllTeachers(); //TODO
    setState(() {
      isLoading = false;
    });
  }

  //TODO: PopUp wo ein Lehrer hinzugefügt wird

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: SideDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _insertTeacher();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(Constants.PT_TEACHER),
        actions: [
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: TextField(
                  controller: _teacher,
                  style: const TextStyle(
                    fontSize: 13
                  ),
                  decoration: InputDecoration(
                    labelText: Constants.PT_TEACHER,
                    labelStyle:
                        TextStyle(color: Colors.blue.shade50, fontSize: 12),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue.shade50, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue.shade50, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  )),
            ),
          )
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(teachers[index].name),
            leading: IconButton(
              onPressed: () => _editTeacher(index),
              icon: const Icon(Icons.edit),
            ),
            trailing: IconButton(
              onPressed: () => _deleteTeacher(index),
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }

  Future _deleteTeacher(int index) async {
    //TODO: Teacher item aus DB löschen

    await refresh();
  }

  Future _editTeacher(int index) async {
    //TODO: Teacher item updaten
    await refresh();
  }

  Future _insertTeacher() async {
    await DatabaseHelper.db.insertTeacher(_teacher.text.toString());
    await refresh();
  }
}
