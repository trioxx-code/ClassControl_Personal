/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';

class CompartmentModel {
  int? compartmentId;
  final String compartmentTitle;

  CompartmentModel({
    this.compartmentId,
    required this.compartmentTitle,
  });

  CompartmentModel copy({
    int? compartmentId,
    String? compartmentTitle,
  }) =>
      CompartmentModel(
        compartmentId: compartmentId ?? this.compartmentId,
        compartmentTitle: compartmentTitle ?? this.compartmentTitle,
      );

  static CompartmentModel fromMap(Map<String, Object?> data) =>
      CompartmentModel(
        compartmentId: data[DatabaseHelper.compartmentId] as int?,
        compartmentTitle: data[DatabaseHelper.compartmentTitle] as String,
      );

  Map<String, Object?> toMap() => {
        DatabaseHelper.compartmentId: compartmentId,
        DatabaseHelper.compartmentTitle: compartmentTitle,
      };
}
