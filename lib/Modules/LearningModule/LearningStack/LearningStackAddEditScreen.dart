/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'LearningStackModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class LearningStackAddEditScreen extends StatefulWidget {
  LearningStackModel? learningStackModel;

  LearningStackAddEditScreen({Key? key, this.learningStackModel})
      : super(key: key);

  @override
  _LearningStackAddEditScreenState createState() =>
      _LearningStackAddEditScreenState();
}

class _LearningStackAddEditScreenState
    extends State<LearningStackAddEditScreen> {
  late TextEditingController _learningStackNameController;
  LearningStackModel? currentModel;
  late Icon icon;
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    currentModel = widget.learningStackModel;
    init();
  }

  @override
  void dispose() {
    _learningStackNameController.dispose();
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
                  onPressed: () async => await _deleteLearningStackModel(),
                )
              : Container(),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: icon,
            onPressed: () => addOrUpdateLearningStackModel(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: TextField(
                controller: _learningStackNameController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Bezeichnung",
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
      name = currentModel!.title;
    }
    _learningStackNameController = TextEditingController(text: name);
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

  void addOrUpdateLearningStackModel() {
    if (isAdd) {
      _insertLearningStackModel();
    } else {
      _updateLearningStackModel();
    }
    Navigator.of(context).pop();
  }

  Future _insertLearningStackModel() async {
    currentModel ??= LearningStackModel(
      title: _learningStackNameController.text,
    );
    await DatabaseHelper.db.insertLearningStackModel(currentModel!.title);
  }

  Future _updateLearningStackModel() async {
    if (currentModel != null) {
      int? id = currentModel!.id;
      currentModel =
          LearningStackModel(id: id, title: _learningStackNameController.text);
      await DatabaseHelper.db.updateLearningStackModel(currentModel!);
    }
  }

  Future _deleteLearningStackModel() async {
    await DatabaseHelper.db.deleteLearningStackModel(currentModel!);
    Navigator.of(context).pop();
  }
}
