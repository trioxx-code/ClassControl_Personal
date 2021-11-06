/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
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

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    //TODO: Datenbank Einträge holen
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: const Text(Constants.PT_TEACHER),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
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
        ));
  }

  Future _deleteTeacher(int index) async {
    //TODO: Teacher item aus DB löschen
    await refresh();
  }

  Future _editTeacher(int index) async {
    //TODO: Teacher item updaten
    await refresh();
  }
}
