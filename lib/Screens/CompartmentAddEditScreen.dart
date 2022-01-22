/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class CompartmentAddEditScreen extends StatefulWidget {
  CompartmentModel? compartmentModel;

  CompartmentAddEditScreen({Key? key, this.compartmentModel}) : super(key: key);

  @override
  _CompartmentAddEditScreenState createState() =>
      _CompartmentAddEditScreenState();
}

//TODO 22.01.2022: Zuordnungstabelle zwischen Lehrer und Fächer

class _CompartmentAddEditScreenState extends State<CompartmentAddEditScreen> {
  late TextEditingController _compartmentController;
  CompartmentModel? currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.compartmentModel;
    init();
  }

  @override
  void dispose() {
    _compartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async => await _deleteTeacherModel(),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async => await _saveTeacherModel(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: TextField(
                  controller: _compartmentController,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "Fach",
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
            buildTeacherList(),
          ],
        ),
      ),
    );
  }

  void init() {
    String compartment = "";
    if (currentModel != null) {
      compartment = currentModel!.compartmentTitle;
    }
    _compartmentController = TextEditingController(text: compartment);
  }

  String getTitle() {
    String res =
        ((currentModel == null) ? Constants.SCREEN_ADD : Constants.SCREEN_EDIT);
    return res;
  }

  Future _saveTeacherModel() async {
    currentModel ??= CompartmentModel(
        compartmentTitle: _compartmentController.text,
        teacherModel: TeacherModel(name: ""));
    int d = await DatabaseHelper.db.insertCompartment(currentModel!);
    Navigator.of(context).pop();
  }

  Future _deleteTeacherModel() async {
    int d = await DatabaseHelper.db.deleteCompartment(currentModel!);
    Navigator.of(context).pop();
  }

  Widget buildTeacherList() {
    return Container(); //TODO: Wie bei BibelVersTrainer
  }
}
