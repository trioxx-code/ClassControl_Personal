/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Screens/NoteAddEditScreen.dart';
import 'package:classcontrol_personal/Screens/NoteDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh(0);
  }

  Future refresh(int op) async {
    setState(() {
      isLoading = true;
    });
    switch (op) {
      case 0:
        notes = await DatabaseHelper.db.getAllNotes();
        break;
      case 1:
        print(currentFilter["filterArg"] + ":" + currentFilter["filterType"]); //@debug
        notes = await DatabaseHelper.db.getAllNotes(
            filterArgs: currentFilter["filterArg"] ?? "",
            filterType: currentFilter["filterType"] ?? "");
        print(notes.length);
        break;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          print("START");
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteAddEditScreen(),
          ));
          print("ENDE");
          await refresh(0);
          print("REFRESH");
        },
      ),
      drawer: const SideDrawer(),
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : notes.isEmpty
            ? const Text("Noch keine Einträge vorhanden",
            style: TextStyle(color: Colors.white, fontSize: 24))
            : buildNotes(),
      )
    );
  }

  Widget buildNotes() => ListView.builder(
    itemCount: notes.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return ListTile(
        title: NoteCardWidget(noteModel: notes[index], index: index),
        leading: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _editNote(notes[index]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              _deleteNote(notes[index]),
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
  );

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
}

/* @info: Brauchbarkeit prüfen
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