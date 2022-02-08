/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/TaskModel.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class TaskAddEditScreen extends StatefulWidget {
  TaskModel? taskModel;

  TaskAddEditScreen({Key? key, this.taskModel}) : super(key: key);

  @override
  _TaskAddEditScreenState createState() => _TaskAddEditScreenState();
}

class _TaskAddEditScreenState extends State<TaskAddEditScreen> {
  final PADDING = 10.0;
  final COLOR = Colors.blueGrey.shade100;
  late Icon icon;
  TaskModel? currentModel;
  late CompartmentModel _compartmentModel;
  late TextEditingController _titleController;
  late TextEditingController _descController;
  int _priority = 1;
  bool isAdd = false;
  bool _isChecked = false;
  List<CompartmentModel> compartments = [];

  @override
  void initState() {
    super.initState();
    if (getTitle() == Constants.SCREEN_ADD) {
      isAdd = true;
      icon = const Icon(Icons.check);
    } else {
      icon = const Icon(Icons.edit);
    }
    currentModel = widget.taskModel;
    init();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
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
                  onPressed: () async => await _deleteTaskModel(),
                )
              : Container(),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: icon,
            onPressed: () => addOrUpdateTaskModel(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "Titel",
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
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: COLOR)),
                child: Row(
                  children: [
                    const Text("Priorität"),
                    Padding(
                        padding: EdgeInsets.all(PADDING),
                        child: Slider(
                          min: 1,
                          max: 10,
                          label: _priority.toString(),
                          divisions: 10,
                          value: _priority.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _priority = value.toInt();
                            });
                          },
                        )),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(PADDING),
                  child: const Text("Erledigt? "),
                ),
                Checkbox(
                    value: _isChecked, onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },)
              ],
            ),
            TextButton(
              child: Text((_compartmentModel.compartmentTitle)),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => selectCompartmentDialog(),
                );
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade900),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                  controller: _descController,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: "Beschreibung",
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

  void init() async {
    var data = ["", ""];
    if (currentModel != null) {
      data[0] = currentModel!.taskTitle;
      data[1] = currentModel!.taskDesc;
      _priority = currentModel!.taskPriority;
      _isChecked = currentModel!.isChecked;
      _compartmentModel = currentModel!.taskCompartment;
    }
    _titleController = TextEditingController(text: data[0]);
    _descController = TextEditingController(text: data[0]);
    compartments = await DatabaseHelper.db.getAllCompartments();
  }

  String getTitle() {
    String res =
        ((currentModel == null) ? Constants.SCREEN_ADD : Constants.SCREEN_EDIT);
    return res;
  }

  void addOrUpdateTaskModel() {
    if (isAdd) {
      _insertTaskModel();
    } else {
      _updateTaskModel();
    }
    Navigator.of(context).pop();
  }

  Future _insertTaskModel() async {
    currentModel ??= TaskModel(
      taskPriority: _priority,
      isChecked: _isChecked,
      taskDateTime: Misc.getCurrentEpochMilli(),
      taskDesc: _descController.text,
      taskTitle: _titleController.text,
      taskCompartment: _compartmentModel,
    );
    int d = await DatabaseHelper.db.insertTask(currentModel!);
  }

  Future _updateTaskModel() async {
    if (currentModel != null) {
      int? id = currentModel!.taskId;
      currentModel = TaskModel(
          taskId: id,
          taskPriority: _priority,
          isChecked: _isChecked,
          taskTitle: _titleController.text,
          taskDesc: _descController.text,
          taskDateTime: Misc.getCurrentEpochMilli(),
          taskCompartment: _compartmentModel);
      await DatabaseHelper.db.updateTask(currentModel!);
    } else
      print("ERROR: updateTaskModel"); //@debug @cleanup
  }

  Future _deleteTaskModel() async {
    int d = await DatabaseHelper.db.deleteTask(currentModel!);
    Navigator.of(context).pop();
  }

  Widget selectCompartmentDialog() => Card(
        child: Column(children: [
          Expanded(
              child: ListView.builder(
            itemCount: compartments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => TextButton(
              child: Text(
                compartments[index].compartmentTitle,
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                _compartmentModel = compartments[index];
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade900),
              ),
            ),
          )),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Schließen",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey.shade900),
            ),
          ),
        ]),
      );
}
