/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';

class NoteAddEditScreen extends StatefulWidget {
  NoteModel? model;

  @override
  _NoteAddEditScreenState createState() => _NoteAddEditScreenState();

  NoteAddEditScreen({Key? key, this.model}) : super(key: key);
}

//TODO: flutter_quill integrieren
//TODO: ^-> Hive implementieren und Speichern der Notiz in Hive übernehmen

class _NoteAddEditScreenState extends State<NoteAddEditScreen> {
  final PADDING = 10.0;
  final COLOR = Colors.blueGrey.shade100;
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  late Icon icon;
  int _priority = 1;
  bool isAdd = false;
  NoteModel? currentModel;
  List<CompartmentModel> compartments = [];
  CompartmentModel? compartmentModel;

  @override
  void initState() {
    super.initState();
    if(getTitle() == Constants.SCREEN_ADD) {
      icon = const Icon(Icons.check);
      isAdd = true;
    } else {
      icon = const Icon(Icons.edit);
    }
    currentModel = widget.model;
    initControllersAndValues();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
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
            icon: icon,
            onPressed: () => addOrUpdateNoteModel(),
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
            Container(
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
            TextButton(
              child: Text(((compartmentModel == null)
                  ? "Fach"
                  : compartmentModel!.compartmentTitle)),
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
      compartmentModel = currentModel!.compartmentModel;
      //TODO: Die Notiz aus den Hive laden und übergeben
    }
    _titleController = TextEditingController(text: val[0]);
    _noteController = TextEditingController(text: val[1]);
    compartments = await DatabaseHelper.db.getAllCompartments();
  }

  void addOrUpdateNoteModel() {
    if (isAdd) {
      print("ADD");
      _saveNoteModel();
    } else {
      _updateNoteModel();
    }
    Navigator.of(context).pop();
  }

  Future _saveNoteModel() async {
    //TODO: Die Notiz auch in Hive speichern
    currentModel ??= NoteModel(
        priority: _priority,
        note: _noteController.text,
        title: _titleController.text,
        date: Misc.getCurrentEpochMilli(),
        compartmentModel: compartmentModel);
    int d = await DatabaseHelper.db.insertNote(currentModel!);
    print("inserted:$d");
  }

  Future _updateNoteModel() async {
    int id = currentModel!.id!;
    currentModel = NoteModel(
        id: id,
        title: _titleController.text,
        note: _noteController.text,
        priority: _priority,
        date: Misc.getCurrentEpochMilli(),
        compartmentModel: compartmentModel);
    id = await DatabaseHelper.db.updateNote(currentModel!);
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
                compartmentModel = compartments[index];
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
