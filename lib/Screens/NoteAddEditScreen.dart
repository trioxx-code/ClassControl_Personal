/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteAddEditScreen extends StatefulWidget {
  NoteModel? model;

  @override
  _NoteAddEditScreenState createState() => _NoteAddEditScreenState();

  NoteAddEditScreen({Key? key, this.model}) : super(key: key);
}

class _NoteAddEditScreenState extends State<NoteAddEditScreen> {
  final PADDING = 10.0;
  final COLOR = Colors.blueGrey.shade100;
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  //TextEditingController _date = new TextEditingController();

  int _priority = 1;
  bool isAdd = false;
  NoteModel? currentModel;
  List<CompartmentModel> compartments = [];
  CompartmentModel? compartmentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.model;
    initControllersAndValues();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    //_date.dispose();
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
            onPressed: () async => await _deleteNoteModel(),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async => await _saveNoteModel(),
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
              child: TextField(
                  controller: _noteController,
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
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue.shade50, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: COLOR)),
              child: Row(
                children: [
                  const Text("Priorität"),
                  Padding(
                    padding: EdgeInsets.all(PADDING),
                    child: NumberPicker(
                      value: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      },
                      maxValue: 10,
                      minValue: 1,
                      itemCount: 11,
                    ),
                  ),
                  TextButton(
                    child: Text(((compartmentModel == null)
                        ? "Fach"
                        : compartmentModel!.compartmentTitle)),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => Container(), //TODO
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initControllersAndValues() async {
    dynamic val = ["", ""];
    if (currentModel != null) {
      val[0] = currentModel!.title;
      val[1] = currentModel!.note;
      _priority = currentModel!.priority;
      //TODO: Die Notiz aus den Hive laden und übergeben
    }
    _titleController = TextEditingController(text: val[0]);
    _noteController = TextEditingController(text: val[1]);
    compartments = await DatabaseHelper.db.getAllCompartments();
  }

  Future _saveNoteModel() async {
    //TODO: Die Notiz auch in Hive speichern
    currentModel ??= NoteModel(
      priority: _priority,
      note: _noteController.text,
      title: _titleController.text,
      date: Misc.getCurrentEpochMilli(),
      //compartmentModel: //@info: TODO
    );
    int d = await DatabaseHelper.db.insertNote(currentModel!);
    Navigator.of(context).pop();
  }

  Future _deleteNoteModel() async {
    int d = await DatabaseHelper.db.deleteNote(currentModel!);
    Navigator.of(context).pop();
  }

  String getTitle() {
    String res =
        ((currentModel == null) ? Constants.SCREEN_ADD : Constants.SCREEN_EDIT);
    return res;
  }
}

//@cleanup
/*Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                  controller: _date,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: "Datum / Uhrzeit",
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
            ),*/
