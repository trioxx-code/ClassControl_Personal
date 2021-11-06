/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:classcontrol_personal/util/Constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //TODO 23.10.21
  final _tableNote = "Note";
  static final noteId = "NoteId";
  static final noteTitle = "Title";
  static final noteNote = "Note";
  static final notePriority = "Priority";
  static final noteDate = "Date";
  static final noteCompartment = "CompartmentId";


  //TODO:
  final _tablePerformance = "Performance";
  final _tableTask = "Task";
  final _tableLearningStack = "LearningStack";
  final _tableLearningItem = "LearningItem";
  final _tableCalendar = "Calendar";
  final _tableCompartment = "Compartment";


  final _tableTimetable = "Timetable";
  static final timetableId = "TimetableId";
  static final timetableTitle = "Titel";
  static final timetableWeekday = "Weekday";
  static final timetableTime = "time";

  final _tableTeacher = "Teacher";
  static final teacherId = "TeacherId";
  static final teacherName = "TeacherName";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper db = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  List<String> _createTables() {
    return [
      "${Constants.SQL_CREATE} $_tableTeacher ($teacherId ${Constants.SQL_PS}, $teacherName ${Constants.SQL_TEXT})",
      "${Constants.SQL_CREATE} $_tableCalendar",
      "${Constants.SQL_CREATE} $_tableLearningItem",
      "${Constants.SQL_CREATE} $_tableLearningStack",
      "${Constants.SQL_CREATE} $_tableNote",
      "${Constants.SQL_CREATE} $_tablePerformance",
      "${Constants.SQL_CREATE} $_tableTask",
      "${Constants.SQL_CREATE} $_tableTimetable ($timetableId ${Constants.SQL_PS}, $timetableTitle ${Constants.SQL_TEXT}, $timetableWeekday ${Constants.SQL_TEXT}, $timetableTime ${Constants.SQL_TEXT});",
      "${Constants.SQL_CREATE} $_tableCompartment ()",
    ];
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, Constants.DB_Name);
    return await openDatabase(path,
        version: Constants.DB_VERSION, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    List tables = _createTables();
    tables.forEach((element) async {
      await db.execute(element);
    });
    return;
  }

  Future close() async {
    final d = await db.database;
    d.close();
  }
}
