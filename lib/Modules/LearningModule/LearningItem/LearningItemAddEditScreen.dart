/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'LearningItemModel.dart';
import '../LearningStack/LearningStackModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class LearningItemAddEditScreen extends StatefulWidget {
  LearningItemAddEditScreen(
      {Key? key, required this.learningStackModel, this.learningItemModel})
      : super(key: key);
  final LearningStackModel learningStackModel;
  LearningItemModel? learningItemModel;

  @override
  _LearningItemAddEditScreenState createState() =>
      _LearningItemAddEditScreenState();
}

class _LearningItemAddEditScreenState extends State<LearningItemAddEditScreen> {
  late TextEditingController _learningItemContentController;
  LearningItemModel? currentModel;
  late Icon icon;
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    currentModel = widget.learningItemModel;
    init();
  }

  @override
  void dispose() {
    _learningItemContentController.dispose();
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
            onPressed: () => addOrUpdateLearningItemModel(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: TextField(
                controller: _learningItemContentController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Inhalt",
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
    String content = "";
    if (currentModel != null) {
      content = currentModel!.content;
    }
    _learningItemContentController = TextEditingController(text: content);
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

  void addOrUpdateLearningItemModel() {
    print("addOrUpdate:$isAdd");
    if (isAdd) {
      _insertLearningItemModel();
    } else {
      _updateLearningItemModel();
    }
    Navigator.of(context).pop();
  }

  Future _insertLearningItemModel() async {
    currentModel ??= LearningItemModel(
        content: _learningItemContentController.text,
        stackId: widget.learningStackModel.id!);
    await DatabaseHelper.db.insertLearningItemModel(currentModel!.content, widget.learningStackModel.id);
  }

  Future _updateLearningItemModel() async {
    if (currentModel != null) {
      int? id = currentModel!.id;
      currentModel = LearningItemModel(
          id: id,
          content: _learningItemContentController.text,
          stackId: widget.learningStackModel.id!);
      await DatabaseHelper.db.updateLearningItemModel(currentModel!);
    }
  }

  Future _deleteLearningStackModel() async {
    await DatabaseHelper.db.deleteLearningItemModel(currentModel!);
    Navigator.of(context).pop();
  }
}
