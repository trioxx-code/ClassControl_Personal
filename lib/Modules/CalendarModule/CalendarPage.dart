/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Util/Misc.dart';
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
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    initCalendar();
    getCalendarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_CALENDAR),
      ),
      body: TableCalendar(
        currentDay: currentDate,
        headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(
                color: Colors.yellow,
                fontSize: 17
            )
        ),
        firstDay: dayValues[0],
        lastDay: dayValues[1],
        focusedDay: dayValues[2],
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            dayValues[2] = selectedDay;
          });
        },
      ),
    );
  }

  Future initCalendar() async {
    currentDate =
        DateTime.fromMillisecondsSinceEpoch(Misc.getCurrentEpochMilli());
    DateTime test = DateTime.fromMillisecondsSinceEpoch(
        Misc.getCurrentEpochMilli());
    //print(test.toString());
    dayValues[0] = DateTime(test.day, test.month, test.year);
    dayValues[1] =
        DateTime.fromMillisecondsSinceEpoch(test.millisecondsSinceEpoch).add(
            const Duration(days: (50 * 365)));
    dayValues[2] = DateTime.fromMillisecondsSinceEpoch(
        test.millisecondsSinceEpoch + 250000);
    print("First: " + dayValues[0].toString());
    print("last: " + dayValues[1].toString());
    print("foxused: " + dayValues[2].toString());
    print("currentDate: " + currentDate.toString());
  }

  Future getCalendarData() async {}
}
