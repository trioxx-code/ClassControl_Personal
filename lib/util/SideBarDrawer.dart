// ignore_for_file: file_names

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
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                //TODO: ClassControl Bild einfügen
                'ClassControl',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(Constants.PT_DASHBOARD),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DashboardPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text(Constants.PT_TIMETABLE),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TimetablePage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text(Constants.PT_CALENDAR),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CalendarPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(Constants.PT_TASK),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TaskPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(Constants.PT_NOTE),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    NotePage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(Constants.PT_LEARNING),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    LearningPage(),
              ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text(Constants.PT_WEB),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      WebPage(),
                ));
              },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(Constants.PT_PERFORMANCE),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PerformancePage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(Constants.PT_SETTINGS),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SettingsPage(),
              ));
            },),
        ],
      ),
    );
  }
}
