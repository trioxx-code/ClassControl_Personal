/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final PADDING = 5.0;
  List<NoteModel> notes = [];
  TextEditingController _title = new TextEditingController();
  TextEditingController _note = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  int _priority = 1;

  //TODO: Popup für die Fächer auswahl.

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    _date.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {});
    notes = await DatabaseHelper.db.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Constants.PT_NOTE),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                controller: _title,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                controller: _note,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                controller: _date,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(PADDING),
              child: TextField(
                controller: _date,
              ),
            ),
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
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
