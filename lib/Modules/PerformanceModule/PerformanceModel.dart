/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import '../CompartmentModule/CompartmentModel.dart';

class PerformanceModel {
  int? id;
  final int mark;
  final String title;
  final CompartmentModel compartment;

  PerformanceModel(
      {this.id,
      required this.title,
      required this.compartment,
      required this.mark});

  PerformanceModel copy(
          {int? id, String? title, int? mark, CompartmentModel? compartment}) =>
      PerformanceModel(
          id: id ?? this.id,
          title: title ?? this.title,
          mark: mark ?? this.mark,
          compartment: compartment ?? this.compartment);

  static PerformanceModel fromMap(Map<String, Object?> data) =>
      PerformanceModel(
          id: data[DatabaseHelper.performanceId] as int?,
          title: data[DatabaseHelper.performanceTitle] as String,
          mark: data[DatabaseHelper.performanceMark] as int,
          compartment:
              data[DatabaseHelper.performanceCompartment] as CompartmentModel);

  Map<String, Object?> toMap() => {
        DatabaseHelper.performanceId: id,
        DatabaseHelper.performanceTitle: title,
        DatabaseHelper.performanceCompartment: compartment,
        DatabaseHelper.performanceMark: mark
      };
}
