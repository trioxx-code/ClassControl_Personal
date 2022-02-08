/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/TaskModel.dart';
import 'package:classcontrol_personal/Screens/TaskAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel taskModel;

  const TaskDetailScreen({required this.taskModel, Key? key}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final double _padding = 20.0;
  late TextEditingController _descController;
  String _dateString = "";

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.taskModel.taskDesc);
    _dateString = Misc.convertEpochToString(widget.taskModel.taskDateTime);
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskModel.taskTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteTaskModel();
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
                builder: (context) => TaskAddEditScreen(
                  taskModel: widget.taskModel,
                ),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(children: [
            Misc.alignedTextItem(Alignment.centerLeft,
                "Erstell-Datum: " + _dateString, Colors.white,
                fontSize: 18),
            Misc.alignedTextItem(
                Alignment.centerRight,
                "Priorität: " + widget.taskModel.taskPriority.toString(),
                Colors.white,
                fontSize: 18),
          ]),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(_padding),
                child: const Text("Erledigt? "),
              ),
              Checkbox(
                value: widget.taskModel.isChecked, onChanged: (value) {}
                )
            ],
          ),
          Text(
            "Fach: " + widget.taskModel.taskCompartment.compartmentTitle,
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          Padding(
            padding: EdgeInsets.all(_padding),
            child: TextField(
                controller: _descController,
                readOnly: true,
                style: const TextStyle(fontSize: 16),
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "Notiz",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle:
                      TextStyle(color: Colors.blue.shade50, fontSize: 16),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue.shade50, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue.shade50, width: 2.0),
                  ),
                )),
          )
        ]),
      ),
    );
  }

  Future _deleteTaskModel() async {
    await DatabaseHelper.db.deleteTask(widget.taskModel);
  }
}
