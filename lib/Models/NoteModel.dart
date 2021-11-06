/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';

class NoteModel {
  final int? id;
  final String title;
  final String note;
  final String date;
  final int priority;
  final CompartmentModel? compartmentModel;

  NoteModel(
      {this.id,
      required this.title,
      required this.priority,
      required this.date,
      required this.note,
      this.compartmentModel});

  NoteModel copy(
          {int? id,
          String? title,
          String? note,
          String? date,
          int? priority,
          CompartmentModel? compartmentModel}) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        date: date ?? this.date,
        priority: priority ?? this.priority,
        compartmentModel: compartmentModel ?? this.compartmentModel,
      );

  static NoteModel fromMap(Map<String, Object?> data) => NoteModel(
        id: data[DatabaseHelper.noteId] as int?,
        title: data[DatabaseHelper.noteTitle] as String,
        note: data[DatabaseHelper.noteNote] as String,
        date: data[DatabaseHelper.noteDate] as String,
        priority: data[DatabaseHelper.notePriority] as int,
        compartmentModel:
            data[DatabaseHelper.noteCompartment] as CompartmentModel,
      );

  Map<String, Object?> toMap() => {
        DatabaseHelper.noteId: id,
        DatabaseHelper.noteTitle: title,
        DatabaseHelper.noteNote: note,
        DatabaseHelper.noteDate: date,
        DatabaseHelper.notePriority: priority,
        DatabaseHelper.noteCompartment: compartmentModel
      };
}
