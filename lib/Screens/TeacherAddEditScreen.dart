/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class TeacherAddEditScreen extends StatefulWidget {
  TeacherModel? compartmentModel;

  TeacherAddEditScreen({Key? key, this.compartmentModel}) : super(key: key);

  @override
  _TeacherAddEditScreenState createState() => _TeacherAddEditScreenState();
}

class _TeacherAddEditScreenState extends State<TeacherAddEditScreen> {
  late TextEditingController _teacherController;
  TeacherModel? currentModel;
  late Icon icon;
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    currentModel = widget.compartmentModel;
    init();
  }

  @override
  void dispose() {
    _teacherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        actions: [
          !isAdd
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async => await _deleteTeacherModel(),
                )
              : Container(),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: icon,
            onPressed: () => addOrUpdateTeacherModel(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: TextField(
                controller: _teacherController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Name",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle:
                      TextStyle(color: Colors.blue.shade50, fontSize: 16),
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
        ),
      ),
    );
  }

  void init() {
    String name = "";
    if (currentModel != null) {
      name = currentModel!.name;
    }
    _teacherController = TextEditingController(text: name);
    if (getTitle() == Constants.SCREEN_ADD) {
      isAdd = true;
      icon = const Icon(Icons.add);
    } else {
      icon = const Icon(Icons.edit);
    }
  }

  String getTitle() {
    String res =
        ((currentModel == null) ? Constants.SCREEN_ADD : Constants.SCREEN_EDIT);
    return res;
  }

  void addOrUpdateTeacherModel() {
    if (isAdd) {
      _insertTeacherModel();
    } else {
      _updateTeacherModel();
    }
    Navigator.of(context).pop();
  }

  Future _insertTeacherModel() async {
    currentModel ??= TeacherModel(
      name: _teacherController.text,
    );
    int d = await DatabaseHelper.db.insertTeacher(currentModel!.name);
  }

  Future _updateTeacherModel() async {
    if (currentModel != null) {
      int? id = currentModel!.id;
      currentModel = TeacherModel(id: id, name: _teacherController.text);
      await DatabaseHelper.db.updateTeacher(currentModel!);
    } else
      print("ERROR: updateTeacherModel"); //@debug @cleanup
  }

  Future _deleteTeacherModel() async {
    int d = await DatabaseHelper.db.deleteTeacher(currentModel!);
    Navigator.of(context).pop();
  }
}
