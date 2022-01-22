/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//@info: https://pub.dev/packages/table_calendar

class _CalendarPageState extends State<CalendarPage> {
  List<DateTime> dayValues =
      List.filled(3, DateTime(1970)); //@info: firstDay, lastDay, focusedDay

  @override
  void initState() {
    super.initState();
    initCalendar();
    getCalendarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Constants.PT_CALENDAR),
      ),
      body: TableCalendar(
        firstDay: dayValues[0],
        lastDay: dayValues[1],
        focusedDay: dayValues[2],
      ),
    );
  }

  Future initCalendar() async {
    DateTime now = DateTime.now();
    dayValues[2] = DateTime(now.day, now.month, now.year);
    dayValues[1] = DateTime(now.day, now.month, now.year + 100);
    dayValues[0] = DateTime(1, 1, 1970);
    dayValues.forEach((element) {
      print(element);
    });
  }

  Future getCalendarData() async {}
}
