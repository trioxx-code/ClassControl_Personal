/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Screens/NoteAddEditScreen.dart';
import 'package:classcontrol_personal/Screens/NoteDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<NoteModel> notes = [];

  //TODO: Popup für die Fächer auswahl.

  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    setState(() {});
    //notes = await DatabaseHelper.db.getAllNotes();
    notes.add(NoteModel(
        title: "Test1",
        date: Misc.getCurrentEpochMilli()+3600*1,
        note: "aoidawiod",
        priority: 5,
        id: 1));
    notes.add(NoteModel(
        title: "Test2",
        date: Misc.getCurrentEpochMilli()+3600*2,
        note: "aoidawiod",
        priority: 5,
        id: 1));
    notes.add(NoteModel(
        title: "Test3",
        date: Misc.getCurrentEpochMilli()+3600*3,
        note: "aoidawiod",
        priority: 5,
        id: 1));
    notes.add(NoteModel(
        title: "Test4",
        date: Misc.getCurrentEpochMilli()+3600*4,
        note: "aoidawiod",
        priority: 5,
        id: 1));
    notes.add(NoteModel(
        title: "Test5",
        date: Misc.getCurrentEpochMilli()+3600*5,
        note: "aoidawiod",
        priority: 5,
        id: 1));
    notes.add(NoteModel(
        title: "Test6",
        date: Misc.getCurrentEpochMilli()+3600*6,
        note: "kaqwdnawoidwa",
        priority: 5,
        id: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //TODO: Auf extra seite gehen, für neue Notiz
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteAddEditScreen(),
          ));
        },
      ),
      drawer: SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_NOTE),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            isThreeLine: true,
            title: Text(
              notes[index].title,
              textAlign: TextAlign.center,
            ),
            subtitle: Row(
              children: [
                const SizedBox(
                  width: 200,
                ),
                Text(
                  Misc.convertEpochToString(notes[index].date),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  width: 200,
                ),
                Text(
                  "Priorität: " + notes[index].priority.toString(),
                  textAlign: TextAlign.end,
                )
              ],
            ),
            leading: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editNote(notes[index]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => print("TODO"), //_deleteNote(notes[index]);
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailScreen(
                  noteModel: notes[index],
                ),
              ));
            },
          );
        },
      ),
    );
  }

  //TODO-FUTURE: Datum+Uhrzeit, Parsing in anderen thread machen

  Future _deleteNote(NoteModel model) async {
    await DatabaseHelper.db.deleteNote(model);
    refresh();
  }

  Future _editNote(NoteModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NoteAddEditScreen(
        model: model,
      ),
    ));
    refresh();
  }
}

/*

subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      parseEpochToString(notes[index].date),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      notes[index].priority.toString(),
                      textAlign: TextAlign.end,
                    )
                  ],
                ),
                /*Wrap( //@cleanup
                  children: [Text(notes[index].note)],
                )*/
              ],
            ),


*/
