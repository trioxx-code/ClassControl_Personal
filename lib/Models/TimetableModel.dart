/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';

class TimetableModel {
  final int? id;
  final String title;
  final String weekday;
  final String time;

  TimetableModel(
      {this.id,
      required this.title,
      required this.weekday,
      required this.time});

  TimetableModel copy(
          {int? id, String? title, String? weekday, String? time}) =>
      TimetableModel(
          id: id ?? this.id,
          title: title ?? this.title,
          weekday: weekday ?? this.weekday,
          time: time ?? this.time);

  static TimetableModel fromMap(Map<String, Object?> data) => TimetableModel(
        id: data[DatabaseHelper.timetableId] as int?,
        title: data[DatabaseHelper.timetableTitle] as String,
        weekday: data[DatabaseHelper.timetableWeekday] as String,
        time: data[DatabaseHelper.timetableTime] as String,
      );

  Map<String, Object?> toMap() => {
        DatabaseHelper.timetableId: id,
        DatabaseHelper.timetableTitle: title,
        DatabaseHelper.timetableWeekday: weekday,
        DatabaseHelper.timetableTime: time,
      };
}
