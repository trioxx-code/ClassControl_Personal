/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'LearningItemModel.dart';
import '../LearningStack/LearningStackModel.dart';
import 'LearningItemAddEditScreen.dart';
import 'package:flutter/material.dart';

class LearningItemDetailScreen extends StatefulWidget {
  const LearningItemDetailScreen(
      {Key? key,
      required this.learningItemModel,
      required this.learningStackModel})
      : super(key: key);
  final LearningItemModel learningItemModel;
  final LearningStackModel learningStackModel;

  @override
  _LearningStackItemPageState createState() => _LearningStackItemPageState();
}

class _LearningStackItemPageState extends State<LearningItemDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.learningStackModel.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteLearningItemModel();
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
                builder: (context) => LearningItemAddEditScreen(
                  learningItemModel: widget.learningItemModel,
                  learningStackModel: widget.learningStackModel,
                ),
              ));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            widget.learningItemModel.content,
            style: TextStyle(color: Colors.blue.shade50, fontSize: 24),
          ),
        ),
      )),
    );
  }

  Future _deleteLearningItemModel() async {
    await DatabaseHelper.db.deleteLearningItemModel(widget.learningItemModel);
  }
}
