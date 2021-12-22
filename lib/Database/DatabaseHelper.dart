/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:classcontrol_personal/Models/CalendarModel.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/LearningItemModel.dart';
import 'package:classcontrol_personal/Models/LearningStackModel.dart';
import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Models/PerformanceModel.dart';
import 'package:classcontrol_personal/Models/TaskModel.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/Models/TimetableModel.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  //TODO: Fächer haben immer mehrere Noten. Zuordnung benötigt. Map?
  final _tableCompartment = "Compartment";
  static final compartmentId = "CompartmentId";
  static final compartmentTitle = "Compartment";
  static final compartmentTeacher = "Teacher";

  final _tableNote = "Note";
  static final noteId = "NoteId";
  static final noteTitle = "Title";
  static final noteNote = "Note";
  static final notePriority = "Priority";
  static final noteDate = "Date";
  static final noteCompartment = "CompartmentId";

  final _tablePerformance = "Performance";
  static final performanceId = "PerformanceId";
  static final performanceTitle = "Title";
  static final performanceCompartment = "CompartmentId";
  static final performanceMark = "Mark";

  final _tableLearningStack = "LearningStack";
  static final learningStackId = "LearningStackId";
  static final learningStackTitle = "LearningStackTitle";

  final _tableLearningItem = "LearningItem";
  static final learningItemId = "LearningItemId";
  static final learningItemContent = "Content";
  static final learningItemStackId = "LearningStackId";

  final _tableCalendar = "Calendar";
  static final calendarId = "CalendarId";
  static final calendarTitle = "Title";
  static final calendarDate = "Date";
  static final calendarMarkColor = "ColorMark";
  static final calendarIsChecked = "Checked";
  static final calendarDesc = "Desc";

  final _tableTask = "Task";
  static final taskId = "TaskId";
  static final taskTitle = "Title";
  static final taskDesc = "Desc";
  static final taskDateTime = "TimeDate";
  static final taskPriority = "Priority";
  static final taskCompartment = "CompartmentId";
  static final taskIsChecked = "Checked";

  final _tableTimetable = "Timetable";
  static final timetableId = "TimetableId";
  static final timetableTitle = "Title";
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

  //TODO: SQL-Vervollständigen
  List<String> _createTables() {
    return [
      "${Constants.SQL_CREATE} $_tableTeacher ($teacherId ${Constants.SQL_PS}, $teacherName ${Constants.SQL_TEXT});",
      "${Constants.SQL_CREATE} $_tableCalendar ($calendarId ${Constants.SQL_PS}, $calendarTitle ${Constants.SQL_TEXT}, $calendarDesc TEXT, $calendarDate INTEGER NOT NULL, $calendarMarkColor INTEGER, $calendarIsChecked INTEGER);",
      "${Constants.SQL_CREATE} $_tableLearningItem ($learningItemId ${Constants.SQL_PS}, $learningItemContent ${Constants.SQL_TEXT}, $learningItemStackId INTEGER NOT NULL, FOREIGN KEY($learningItemStackId) REFERENCES $_tableLearningStack.$learningStackId);",
      "${Constants.SQL_CREATE} $_tableLearningStack ($learningStackId ${Constants.SQL_PS}, $learningStackTitle ${Constants.SQL_TEXT});",
      "${Constants.SQL_CREATE} $_tableNote ($noteId ${Constants.SQL_PS}, $noteTitle ${Constants.SQL_TEXT}, $noteNote TEXT, $notePriority INTEGER NOT NULL, $noteDate INTEGER NOT NULL, $noteCompartment INTEGER NOT NULL, FOREIGN KEY($noteCompartment) REFERENCES $_tableCompartment.$compartmentId);",
      //TODO: "${Constants.SQL_CREATE} $_tablePerformance ($performanceId ${Constants.SQL_PS}, $performanceTitle ${Constants.SQL_TEXT}, $performanceMark);",
      "${Constants.SQL_CREATE} $_tableTask ($taskId ${Constants.SQL_PS}, $taskTitle ${Constants.SQL_TEXT}, $taskDesc ${Constants.SQL_TEXT}, $taskPriority INTEGER NOT NULL, $taskDateTime INTEGER NOT NULL, $taskCompartment INTEGER NOT NULL, $taskIsChecked INTEGER NOT NULL, FOREIGN KEY($taskCompartment) REFERENCES $_tableCompartment.$compartmentId);",
      "${Constants.SQL_CREATE} $_tableTimetable ($timetableId ${Constants.SQL_PS}, $timetableTitle ${Constants.SQL_TEXT}, $timetableWeekday ${Constants.SQL_TEXT}, $timetableTime ${Constants.SQL_TEXT});",
      "${Constants.SQL_CREATE} $_tableCompartment ($compartmentId ${Constants.SQL_PS}, $compartmentTitle ${Constants.SQL_TEXT}, $compartmentTeacher INTEGER NOT NULL, FOREIGN KEY($compartmentTeacher) REFERENCES $_tableTeacher.$teacherId);",
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
    print("TABLES:");
    tables.forEach((element) async {
      print(element.toString());
      //await db.execute(element);
    });
    return;
  }

  Future close() async {
    final d = await db.database;
    d.close();
  }

  Future<List<NoteModel>> getAllNotes() async {
    final d = await db.database;
    List<NoteModel> notes = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableNote");
    data.forEach((element) {
      notes.add(NoteModel(
        id: element[noteId],
        priority: element[notePriority],
        date: element[noteDate],
        note: element[noteNote],
        title: element[noteTitle],
        compartmentModel: element[noteCompartment],
      ));
    });
    return notes;
  }

  Future<List<TimetableModel>> getAllTimetableData() async {
    final d = await db.database;
    List<TimetableModel> tt = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableTimetable");
    data.forEach((element) {
      tt.add(TimetableModel(
        title: element[timetableTitle],
        weekday: element[timetableWeekday],
        time: element[timetableTime],
        id: element[timetableId],
      ));
    });
    return tt;
  }

  Future<List<TeacherModel>> getAllTeachers() async {
    final d = await db.database;
    List<TeacherModel> teachers = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableTeacher");
    data.forEach((element) {
      teachers.add(
          TeacherModel(id: element[teacherId], name: element[teacherName]));
    });
    return teachers;
  }

  Future<int> insertTeacher(String teacherName) async {
    final d = await db.database;
    int res = 0;
    //TODO: Eintrag hinzufügen.
    return res;
  }




  Future<List<CompartmentModel>> getAllCompartments() async {
    final d = await db.database;
    List<CompartmentModel> compartments = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableCompartment");
    data.forEach((element) {
      compartments.add(CompartmentModel(
        compartmentId: element[compartmentId],
        compartmentTitle: element[compartmentTitle],
        teacherModel: element[compartmentTeacher],
      ));
    });
    return compartments;
  }

  Future<List<CalendarModel>> getAllAppointments() async {
    final d = await db.database;
    List<CalendarModel> appointments = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableCalendar");
    data.forEach((element) {
      appointments.add(CalendarModel(
        id: element[calendarId],
        title: element[calendarTitle],
        desc: element[calendarDesc],
        markColor: element[calendarMarkColor],
        datetime: element[calendarDate],
        checked: element[calendarIsChecked],
      ));
    });
    return appointments;
  }

  //TODO: SQL-Vervollständigen
  Future<List<TaskModel>> getAllTasks() async {
    final d = await db.database;
    List<TaskModel> tasks = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableTask");
    data.forEach((element) {
      tasks.add(TaskModel(
        taskId: element[taskId],
        taskTitle: element[taskTitle],
        taskDesc: element[taskDesc],
        taskDateTime: element[taskDateTime],
        isChecked: element[taskIsChecked],
        taskCompartment: CompartmentModel(
          compartmentId: element[compartmentId],
          teacherModel:
              TeacherModel(id: element[teacherId], name: element[teacherName]),
          compartmentTitle: element[compartmentTitle],
        ),
        taskPriority: element[taskPriority],
      ));
    });
    return tasks;
  }

  //TODO: SQL-Vervollständigen
  Future<List<PerformanceModel>> getAllPerformances() async {
    final d = await db.database;
    List<PerformanceModel> perfomances = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tablePerformance");
    data.forEach((element) {
      perfomances.add(PerformanceModel(
        id: element[performanceId],
        title: performanceTitle,
        compartment: CompartmentModel(
            compartmentId: element[compartmentId],
            compartmentTitle: element[compartmentTitle],
            teacherModel: TeacherModel(
                id: element[teacherId], name: element[teacherName])),
        mark: element[performanceMark],
      ));
    });
    return perfomances;
  }

  //TODO: SQL-Vervollstädigen
  Future<List<LearningStackModel>> getAllLearningStacks() async {
    final d = await db.database;
    List<LearningStackModel> stacks = [];
    List<Map> data = await d.rawQuery("SELECT * FROM $_tableLearningStack");
    data.forEach((element) {
      stacks.add(LearningStackModel(
          id: element[learningStackId], title: element[learningStackTitle]));
    });
    return stacks;
  }

  //TODO: SQL-Vervollständigen
  Future<List<LearningItemModel>> getAllLearningItemsByStack(
      LearningStackModel stack) async {
    final d = await db.database;
    List<LearningItemModel> items = [];
    List<Map> data = await d.rawQuery(
        "SELECT * FROM $_tableLearningItem WHERE $_tableLearningItem.$learningItemStackId = ${stack.id}");
    data.forEach((element) {
      items.add(LearningItemModel(
        id: element[learningItemId],
        content: element[learningItemContent],
        stackId: stack.id!,
      ));
    });
    return items;
  }
}
