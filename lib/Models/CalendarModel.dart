/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

class CalendarModel {
  final String title;
  final DateTime day;
  final bool? checked;
  final String desc;
  CalendarModel({required this.title, required this.day, required this.desc, this.checked});
}
