/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/LearningStackModel.dart';
import 'package:classcontrol_personal/Pages/LearningItemPage.dart';
import 'package:classcontrol_personal/Screens/LearningStackAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class LearningStackDetailScreen extends StatefulWidget {
  final LearningStackModel learningStackModel;

  const LearningStackDetailScreen({Key? key, required this.learningStackModel})
      : super(key: key);

  @override
  _LearningStackDetailScreenState createState() =>
      _LearningStackDetailScreenState();
}

class _LearningStackDetailScreenState extends State<LearningStackDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.PT_TEACHER),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteLearningStackModel();
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
                builder: (context) => LearningStackAddEditScreen(
                  learningStackModel: widget.learningStackModel,
                ),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.learningStackModel.title,
                style: TextStyle(color: Colors.blue.shade50, fontSize: 24),
              ),
            ),
            TextButton(
              child: const Text(
                "Items",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LearningItemPage(
                      learningStackModel: widget.learningStackModel),
                ));
              },
            )
          ],
        ),
      )),
    );
  }

  Future _deleteLearningStackModel() async {
    await DatabaseHelper.db.deleteLearningStackModel(widget.learningStackModel);
  }
}
