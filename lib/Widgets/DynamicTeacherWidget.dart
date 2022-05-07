/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import '../Modules/CompartmentModule/CompartmentModel.dart';
import '../Modules/TeacherModule/TeacherModel.dart';
import 'package:flutter/material.dart';

class DynamicTeacherWidget extends StatefulWidget {
  final CompartmentModel compartmentModel;

  const DynamicTeacherWidget({Key? key, required this.compartmentModel})
      : super(key: key);

  @override
  _DynamicTeacherWidgetState createState() => _DynamicTeacherWidgetState();
}

class _DynamicTeacherWidgetState extends State<DynamicTeacherWidget> {
  late CompartmentModel compartmentModel;
  bool isLoading = false;
  Map<String, bool?> teacherList = {};
  List<TeacherModel> allTeachers = [];

  Future refreshAllTeachers() async {
    setState(() {
      isLoading = true;
    });
    allTeachers = await DatabaseHelper.db
        .getNotAssignedTeachersFromCompartment(compartmentModel);
    allTeachers.forEach((element) {
      teacherList[element.name] = false;
    });
    setState(() {
      isLoading = false;
    });
  }

  void getItems() {
    teacherList.forEach((key, value) {
      if (value == true) {
        allTeachers.forEach((element) {
          if (element.name == key) {
            addTCA(element.id!, compartmentModel.compartmentId!);
          }
        });
      }
    });
  }

  Future addTCA(int tId, int cId) async {
//print("cID: $cId vID: $vId");
    int i = 0;
    i = await DatabaseHelper.db.insertTCA({
      DatabaseHelper.tcaTId: tId,
      DatabaseHelper.tcaCId: cId,
    });
//print("inserted id: $i");
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView(
          children: teacherList.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: teacherList[key],
              activeColor: Colors.deepPurple[400],
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  teacherList[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Schließen",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
          TextButton(
            child: Text("Bestätigen",
                style: TextStyle(color: Colors.blue.shade900, fontSize: 18)),
            onPressed: () {
              getItems();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    compartmentModel = widget.compartmentModel;
    refreshAllTeachers();
  }
}
