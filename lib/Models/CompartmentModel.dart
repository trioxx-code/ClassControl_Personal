/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';

class CompartmentModel {
  int? compartmentId;
  final String compartmentTitle;
  final TeacherModel teacherModel;

  CompartmentModel(
      {compartmentId,
      required this.compartmentTitle,
      required this.teacherModel});

  CompartmentModel copy(
          {int? compartmentId,
          String? compartmentTitle,
          TeacherModel? teacherModel}) =>
      CompartmentModel(
          compartmentId: compartmentId ?? this.compartmentId,
          compartmentTitle: compartmentTitle ?? this.compartmentTitle,
          teacherModel: teacherModel ?? this.teacherModel);

  static CompartmentModel fromMap(
          Map<String, Object?> data) =>
      CompartmentModel(
          compartmentId: data[DatabaseHelper.compartmentId] as int?,
          compartmentTitle: data[DatabaseHelper.compartmentTitle] as String,
          teacherModel:
              data[DatabaseHelper.compartmentTeacher] as TeacherModel);

  Map<String, Object?> toMap() => {
        DatabaseHelper.compartmentId: compartmentId,
        DatabaseHelper.compartmentTitle: compartmentTitle,
        DatabaseHelper.compartmentTeacher: teacherModel,
      };
}
