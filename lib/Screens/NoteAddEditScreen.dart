/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NoteAddEditScreen extends StatefulWidget {
  NoteModel? model;

  @override
  _NoteAddEditScreenState createState() => _NoteAddEditScreenState();

  NoteAddEditScreen({this.model});
}

class _NoteAddEditScreenState extends State<NoteAddEditScreen> {
  final PADDING = 10.0;
  final COLOR = Colors.blueGrey.shade100;
  TextEditingController _title = new TextEditingController();
  TextEditingController _note = new TextEditingController();
  TextEditingController _date = new TextEditingController();
  int _priority = 1;
  bool isAdd = false;
  late String title;

  @override
  void initState() {
    super.initState();
    //TODO: Erkennen ob add oder edit gemacht wird
    title = Constants.SCREEN_ADD;
  }

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
              Container(
                decoration: BoxDecoration(border: Border.all(color: COLOR)),
                child: Padding(
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
              ),
            ],
          ),
        ),
    );
  }
}
