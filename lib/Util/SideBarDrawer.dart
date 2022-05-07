/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Modules/LearningModule/LearningPage.dart';
import 'package:classcontrol_personal/Modules/NoteModule/NotePage.dart';
import 'package:classcontrol_personal/Modules/PerformanceModule/PerformancePage.dart';
import 'package:classcontrol_personal/Modules/TaskModule/TaskPage.dart';
import 'package:classcontrol_personal/Modules/TimetableModule/TimetablePage.dart';
import '../Modules/CalendarModule/CalendarPage.dart';
import '../Pages/DashboardPage.dart';
import 'package:classcontrol_personal/Pages/SettingsPage.dart';
import 'package:classcontrol_personal/Pages/WebPage.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';

//TODO: Icons anpassen. Evt. muss push ersetzt werden durch anderes

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Constants.CLASSCONTROL_SCALED_ICON_PATH),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(Constants.PT_DASHBOARD),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text(Constants.PT_TIMETABLE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const TimetablePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text(Constants.PT_CALENDAR),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CalendarPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_outlined),
              title: const Text(Constants.PT_TASK),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const TaskPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.sticky_note_2_rounded),
              title: const Text(Constants.PT_NOTE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const NotePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text(Constants.PT_LEARNING),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LearningPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text(Constants.PT_WEB),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const WebPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text(Constants.PT_PERFORMANCE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const PerformancePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(Constants.PT_SETTINGS),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
