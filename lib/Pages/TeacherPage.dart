/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/Screens/TeacherAddEditScreen.dart';
import 'package:classcontrol_personal/Screens/TeacherDetailScreen.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({Key? key}) : super(key: key);

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
    teachers = await DatabaseHelper.db.getAllTeachers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: SideDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TeacherAddEditScreen(),
          ));
        },
      ),
      appBar: AppBar(
        title: const Text(Constants.PT_TEACHER),
      ),
      body: ListView.builder(
        itemCount: teachers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            //isThreeLine: true,
            title: Text(teachers[index].name),
            leading: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editTeacher(teachers[index]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  _deleteTeacher(teachers[index]), //_deleteNote(notes[index]);
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeacherDetailScreen(
                  teacherModel: teachers[index],
                ),
              ));
            },
          );
        },
      ),
    );
  }

  Future _deleteTeacher(TeacherModel model) async {
    await DatabaseHelper.db.deleteTeacher(model);
    refresh();
  }

  Future _editTeacher(TeacherModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TeacherAddEditScreen(
        compartmentModel: model,
      ),
    ));
    refresh();
  }
}
