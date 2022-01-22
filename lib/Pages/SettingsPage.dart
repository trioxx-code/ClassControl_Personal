// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Pages/CompartmentPage.dart';
import 'package:classcontrol_personal/Pages/TeacherPage.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/util/SharedPreferencesHelper.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:pref/pref.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  dynamic _service;
  int val = 0;

  @override
  void initState() {
    super.initState();
    initService();
    refresh();
  }

  Future initService() async {
    _service = PrefServiceCache();
    await _service.setDefaultValues({
      Constants.CCP_THEME_MODE: Constants.CCP_THEME_DARK,
    });
  }

  Future refresh() async {
    setState(() {});
    String? theme =
        await SharedPreferencesHelper.readDataString(Constants.CCP_THEME_MODE);
    setState(() {
      val = (theme == Constants.CCP_THEME_LIGHT) ? 1 : 2;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_SETTINGS),
      ),
      body: PrefService(
        service: _service,
        child: PrefPage(
          children: [
            buildScreenTextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TeacherPage(),
                ));
              },
              buttonText: Constants.PT_TEACHER,
            ),
            buildScreenTextButton(
                buttonText: Constants.PT_COMPARTMENT,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompartmentPage()));
                }),
            //buildThemePref(), //TODO
          ],
        ),
      ),
    );
  }

  Widget buildScreenTextButton({onPressed, String buttonText = ""}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(50.0)),
            backgroundColor: MaterialStateProperty.all(Colors.grey),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 24,
                color: Colors.yellow,
                backgroundColor: Colors.grey),
          ),
          onPressed: onPressed),
    );
  }

  Widget buildThemePref() {
    return Column(children: [
      const PrefTitle(
        title: Text("Theme"),
      ),
      RadioListTile(
        title: Text("Hell"),
        value: 1,
        groupValue: val,
        onChanged: (value) {
          val = int.parse(value.toString());
          print(val);
          if (val == 1)
            SharedPreferencesHelper.saveData(
                Constants.CCP_THEME_MODE, Constants.CCP_THEME_LIGHT);
          refresh();
        },
        activeColor: Colors.green,
      ),
      RadioListTile(
        title: Text("Dunkel"),
        value: 2,
        groupValue: val,
        onChanged: (value) {
          val = int.parse(value.toString());
          print(val);
          if (val == 2)
            SharedPreferencesHelper.saveData(
                Constants.CCP_THEME_MODE, Constants.CCP_THEME_DARK);
          refresh();
        },
        activeColor: Colors.green,
      ),
    ]);
  }
}
