/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:flutter/material.dart';

class CalendarModel {
  int? id;
  final String title;
  final DateTime datetime;
  final bool? checked;
  final String desc;
  final Color markColor;

  CalendarModel(
      {this.id,
      required this.title,
      required this.desc,
      this.checked,
      required this.markColor,
      required this.datetime});

  CalendarModel copy({
    int? id,
    String? title,
    String? desc,
    DateTime? datetime,
    Color? markColor,
    bool? checked,
  }) =>
      CalendarModel(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        datetime: datetime ?? this.datetime,
        markColor: markColor ?? this.markColor,
        checked: checked ?? this.checked,
      );

  static CalendarModel fromMap(Map<String, Object?> data) => CalendarModel(
      id: data[DatabaseHelper.calendarId] as int,
      title: data[DatabaseHelper.calendarTitle] as String,
      desc: data[DatabaseHelper.calendarDesc] as String,
      datetime: data[DatabaseHelper.calendarDate] as DateTime,
      markColor: data[DatabaseHelper.calendarMarkColor] as Color,
      checked: data[DatabaseHelper.calendarIsChecked] as bool);

  Map<String, Object?> toMap() => {
        DatabaseHelper.calendarId: id,
        DatabaseHelper.calendarTitle: title,
        DatabaseHelper.calendarDesc: desc,
        DatabaseHelper.calendarDate: datetime,
        DatabaseHelper.calendarIsChecked: checked,
        DatabaseHelper.calendarMarkColor: markColor
      };
}
