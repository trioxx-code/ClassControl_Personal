/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Constants.PT_DASHBOARD),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text("TODO"),
          ],
        ),
      ),
    );
  }
}
