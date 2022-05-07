/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'CompartmentModel.dart';
import '../TeacherModule/TeacherModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class CompartmentAddEditScreen extends StatefulWidget {
  CompartmentModel? compartmentModel;

  CompartmentAddEditScreen({Key? key, this.compartmentModel}) : super(key: key);

  @override
  _CompartmentAddEditScreenState createState() =>
      _CompartmentAddEditScreenState();
}

class _CompartmentAddEditScreenState extends State<CompartmentAddEditScreen> {
  late TextEditingController _compartmentController;
  late Icon icon;
  CompartmentModel? currentModel;
  bool isAdd = false;

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
          !isAdd
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async => await _deleteCompartmentModel(),
                )
              : Container(),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: icon,
            onPressed: () => addOrUpdateCompartmentModel(),
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
    if (getTitle() == Constants.SCREEN_ADD) {
      isAdd = true;
      icon = const Icon(Icons.check);
    } else {
      icon = const Icon(Icons.edit);
    }
  }

  String getTitle() {
    String res =
        ((currentModel == null) ? Constants.SCREEN_ADD : Constants.SCREEN_EDIT);
    return res;
  }

  void addOrUpdateCompartmentModel() {
    if (isAdd) {
      _insertCompartmentModel();
    } else {
      _updateCompartmentModel();
    }
    Navigator.of(context).pop();
  }

  Future _insertCompartmentModel() async {
    currentModel ??= CompartmentModel(
      compartmentTitle: _compartmentController.text,
    );
    int d = await DatabaseHelper.db.insertCompartment(currentModel!);
  }

  Future _updateCompartmentModel() async {
    if (currentModel != null) {
      int? id = currentModel!.compartmentId;
      currentModel = CompartmentModel(
          compartmentId: id, compartmentTitle: _compartmentController.text);
      await DatabaseHelper.db.updateCompartment(currentModel!);
    } else
      print("ERROR: updateCompartmentModel"); //@debug @cleanup
  }

  Future _deleteCompartmentModel() async {
    int d = await DatabaseHelper.db.deleteCompartment(currentModel!);
    Navigator.of(context).pop();
  }
}
