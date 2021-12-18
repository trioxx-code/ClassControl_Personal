/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';

class LearningStackModel {
  int? id;
  final String title;

  LearningStackModel({this.id, required this.title});

  LearningStackModel copy({
    int? id,
    String? title,
  }) =>
      LearningStackModel(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  static LearningStackModel fromMap(Map<String, Object?> data) =>
      LearningStackModel(
        id: data[DatabaseHelper.learningStackId] as int,
        title: data[DatabaseHelper.learningStackTitle] as String,
      );

  Map<String, Object?> toMap() => {
        DatabaseHelper.learningStackId: id,
        DatabaseHelper.learningStackTitle: title,
      };
}
