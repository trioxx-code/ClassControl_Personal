/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';

class TeacherModel {
  final int? id;
  final String name;
  TeacherModel({this.id, required this.name});

  TeacherModel copy({int? id, String? name}) => TeacherModel(
      id: id ?? this.id, name: name ?? this.name);

  static TeacherModel fromMap(Map<String, Object?> data) => TeacherModel(
      id: data[DatabaseHelper.teacherId] as int?,
      name: data[DatabaseHelper.teacherName] as String);

  Map<String, Object?> toMap() => {
    DatabaseHelper.teacherId: id,
    DatabaseHelper.teacherName: name
  };
}