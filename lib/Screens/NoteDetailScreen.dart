/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:flutter/material.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteModel noteModel;
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
  NoteDetailScreen({required this.noteModel});
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {

  //TODO: Das Notemaodell übergeben und anzeigen

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteModel.title),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
