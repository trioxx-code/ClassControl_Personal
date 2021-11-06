/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Pages/DashboardPage.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PreScreen());
}

Future init() async {
  //TODO: Prüfen ob das erste Mal gestartet wird
}

class PreScreen extends StatefulWidget {
  const PreScreen({Key? key}) : super(key: key);

  @override
  _PreScreenState createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  String _themeMode = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
        ),
        brightness: /*(_themeMode == Constants.CCP_THEME_LIGHT)? Brightness.light :*/ Brightness
            .dark,
      ),
      home: DashboardPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    //getThemeData();
  }

  Future getThemeData() async {
    var val =
        await SharedPreferencesHelper.readDataString(Constants.CCP_THEME_MODE);
    _themeMode = val ?? "";
    print(_themeMode);
  }
}
