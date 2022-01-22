/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Screens/NoteAddEditScreen.dart';
import 'package:classcontrol_personal/Screens/NoteDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:classcontrol_personal/Widgets/NoteCardWidget.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<NoteModel> notes = [];
  bool isAsc = true;
  Icon filterIcon = const Icon(Icons.compare_arrows);
  Map currentFilter = {
    "filterArg": DatabaseHelper.noteId,
    "filterType": Constants.FILTER_ASC
  };

  //TODO: Popup für die Fächer auswahl.

  @override
  void initState() {
    super.initState();
    generateDebugData();
    refresh(0);
  }

  void generateDebugData() {
    for (int i = 1; i < 21; i++) {
      notes.add(NoteModel(
          title: "Test$i",
          date: (Misc.getCurrentEpochMilli() + 3600 * 60 * i),
          note: "kaqwdnawoidwa" + i.toString(),
          priority: i % 5 * 2 % 7,
          id: i));
    }
  }

  Future refresh(int op) async {
    setState(() {});
    switch (op) {
      case 0:
        notes = await DatabaseHelper.db.getAllNotes();
        break;
      case 1:
        print(currentFilter["filterArg"] + ":" + currentFilter["filterType"]);
        notes = await DatabaseHelper.db.getAllNotes(
            filterArgs: currentFilter["filterArg"] ?? "",
            filterType: currentFilter["filterType"] ?? "");
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteAddEditScreen(),
          ));
        },
      ),
      drawer: SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_NOTE),
        actions: [
          IconButton(
            icon: filterIcon,
            onPressed: () {
              if (isAsc) {
                filterIcon = const Icon(Icons.arrow_downward);
                currentFilter["filterType"] = Constants.FILTER_ASC;
                isAsc = false;
              } else {
                filterIcon = const Icon(Icons.arrow_upward);
                currentFilter["filterType"] = Constants.FILTER_DESC;
                isAsc = true;
              }
              refresh(1);
            },
          ),
          PopupMenuButton<String>(
            onSelected: startSorting,
            itemBuilder: (BuildContext context) {
              return {"Reset", "Priorität", "Titel", "Datum", "Fach"}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            //isThreeLine: true,
            title: NoteCardWidget(noteModel: notes[index], index: index),
            leading: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editNote(notes[index]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  _deleteNote(notes[index]), //_deleteNote(notes[index]);
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
    refresh(0);
  }

  Future _editNote(NoteModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NoteAddEditScreen(
        model: model,
      ),
    ));
    refresh(0);
  }

  void startSorting(String val) {
    switch (val) {
      case "Reset":
        currentFilter["filterArg"] = DatabaseHelper.noteId;
        currentFilter["filterType"] = Constants.FILTER_ASC;
        filterIcon = const Icon(Icons.compare_arrows);
        isAsc = true;
        break;
      case "Titel":
        currentFilter["filterArg"] = DatabaseHelper.noteTitle;
        break;
      case "Priorität":
        currentFilter["filterArg"] = DatabaseHelper.notePriority;
        break;
      case "Fach":
        currentFilter["filterArg"] = DatabaseHelper.noteCompartment;
        break;
      case "Datum":
        currentFilter["filterArg"] = DatabaseHelper.noteDate;
        break;
    }
    refresh(1);
  }

/*
  void _runFilter(String keyword) {
    if(keyword.isEmpty) {
      displayedNotes = allNotes;
    } else {
      displayedNotes = allNotes..where((find) =>
          find.toMap()[filterMapping()].toString().toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {});
  }
*/

}
