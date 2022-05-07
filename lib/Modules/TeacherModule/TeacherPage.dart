/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'TeacherModel.dart';
import 'TeacherAddEditScreen.dart';
import 'TeacherDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
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
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TeacherAddEditScreen(),
            ));
            refresh();
          },
        ),
        appBar: AppBar(
          title: const Text(Constants.PT_TEACHER),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : teachers.isEmpty
                  ? const Text(Constants.NO_DATA,
                      style: TextStyle(color: Colors.white, fontSize: 24))
                  : buildTeachers(),
        ));
  }

  Widget buildTeachers() => ListView.builder(
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
                  _deleteTeacher(teachers[index]),
            ),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeacherDetailScreen(
                  teacherModel: teachers[index],
                ),
              ));
              refresh();
            },
          );
        },
      );

  Future _deleteTeacher(TeacherModel model) async {
    await DatabaseHelper.db.deleteTeacher(model);
    await refresh();
  }

  Future _editTeacher(TeacherModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TeacherAddEditScreen(
        compartmentModel: model,
      ),
    ));
    await refresh();
  }
}
