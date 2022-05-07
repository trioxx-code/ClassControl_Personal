/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'NoteModel.dart';
import 'NoteAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteModel noteModel;

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();

  NoteDetailScreen({Key? key, required this.noteModel}) : super(key: key);
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final double _padding = 20.0;
  late TextEditingController _noteController;
  String _dateString = "";
  bool _showCompartment = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.noteModel.note);
    _dateString = Misc.convertEpochToString(widget.noteModel.date);
    if(widget.noteModel.compartmentModel != null) {
      _showCompartment = widget.noteModel.compartmentModel!.compartmentId != 1 ? true : false;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteModel.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteNoteModel();
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
                builder: (context) => NoteAddEditScreen(
                  model: widget.noteModel,
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
                "Priorität: " + widget.noteModel.priority.toString(),
                Colors.white,
                fontSize: 18),
          ]),
          (_showCompartment)
              ? Text(
                  "Fach: " +
                      widget.noteModel.compartmentModel!.compartmentTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                )
              : Container(), //@info: keep empty
          Padding(
            padding: EdgeInsets.all(_padding),
            child: TextField(
                controller: _noteController,
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
                    //borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue.shade50, width: 2.0),
                    //borderRadius: BorderRadius.circular(25.0),
                  ),
                )),
          )
        ]),
      ),
    );
  }

  Future _deleteNoteModel() async {
    await DatabaseHelper.db.deleteNote(widget.noteModel);
  }
}
