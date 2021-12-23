/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Pages/CalendarPage.dart';
import 'package:classcontrol_personal/Pages/DashboardPage.dart';
import 'package:classcontrol_personal/Pages/LearningPage.dart';
import 'package:classcontrol_personal/Pages/NotePage.dart';
import 'package:classcontrol_personal/Pages/PerformancePage.dart';
import 'package:classcontrol_personal/Pages/SettingsPage.dart';
import 'package:classcontrol_personal/Pages/TaskPage.dart';
import 'package:classcontrol_personal/Pages/TimetablePage.dart';
import 'package:classcontrol_personal/Pages/WebPage.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';

//TODO: Icons anpassen. Evt. muss push ersetzt werden durch anderes

class SideDrawer extends StatelessWidget {
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
                  builder: (context) => DashboardPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text(Constants.PT_TIMETABLE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TimetablePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text(Constants.PT_CALENDAR),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CalendarPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_outlined),
              title: const Text(Constants.PT_TASK),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TaskPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.sticky_note_2_rounded),
              title: const Text(Constants.PT_NOTE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NotePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text(Constants.PT_LEARNING),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LearningPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.cloud),
              title: const Text(Constants.PT_WEB),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => WebPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text(Constants.PT_PERFORMANCE),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PerformancePage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(Constants.PT_SETTINGS),
              onTap: () async {
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
