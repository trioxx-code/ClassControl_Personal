/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';

class TaskModel {
  int? taskId;
  final String taskTitle;
  final String taskDesc;
  final int taskDateTime;
  final int taskPriority;
  final CompartmentModel taskCompartment;

  TaskModel(
      {taskId,
      required this.taskTitle,
      required this.taskDesc,
      required this.taskDateTime,
      required this.taskPriority,
      required this.taskCompartment});

  TaskModel copy(
          {int? taskId,
          String? taskTitle,
          String? taskDesc,
          int? taskDateTime,
          int? taskPriority,
          CompartmentModel? taskCompartment}) =>
      TaskModel(
          taskId: taskId ?? this.taskId,
          taskTitle: taskTitle ?? this.taskTitle,
          taskDesc: taskDesc ?? this.taskDesc,
          taskDateTime: taskDateTime ?? this.taskDateTime,
          taskPriority: taskPriority ?? this.taskPriority,
          taskCompartment: taskCompartment ?? this.taskCompartment);

  static TaskModel fromMap(Map<String, Object?> data) => TaskModel(
      taskId: data[DatabaseHelper.taskId] as int?,
      taskTitle: data[DatabaseHelper.taskTitle] as String,
      taskDesc: data[DatabaseHelper.taskDesc] as String,
      taskDateTime: data[DatabaseHelper.taskDateTime] as int,
      taskPriority: data[DatabaseHelper.taskPriority] as int,
      taskCompartment:
          data[DatabaseHelper.taskCompartment] as CompartmentModel);

  Map<String, Object?> toMap() => {
        DatabaseHelper.taskId: taskId,
        DatabaseHelper.taskTitle: taskTitle,
        DatabaseHelper.taskDesc: taskDesc,
        DatabaseHelper.taskDateTime: taskDateTime,
        DatabaseHelper.taskPriority: taskPriority,
        DatabaseHelper.taskCompartment: taskCompartment
      };
}
