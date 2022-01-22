/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';

class LearningItemModel {
  int? id;
  final int stackId;
  final String content;

  LearningItemModel({this.id, required this.stackId, required this.content});

  LearningItemModel copy({
    int? id,
    int? stackId,
    String? content,
  }) =>
      LearningItemModel(
        id: id ?? this.id,
        stackId: stackId ?? this.stackId,
        content: content ?? this.content,
      );

  static LearningItemModel fromMap(Map<String, Object?> data) =>
      LearningItemModel(
        id: data[DatabaseHelper.learningItemId] as int,
        stackId: data[DatabaseHelper.learningItemStackId] as int,
        content: data[DatabaseHelper.learningItemContent] as String,
      );

  Map<String, Object?> toMap() => {
        DatabaseHelper.learningItemId: id,
        DatabaseHelper.learningItemStackId: stackId,
        DatabaseHelper.learningItemContent: content,
      };
}
