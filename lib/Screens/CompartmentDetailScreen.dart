/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Models/TeacherModel.dart';
import 'package:classcontrol_personal/Screens/CompartmentAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Widgets/DynamicTeacherWidget.dart';
import 'package:flutter/material.dart';

class CompartmentDetailScreen extends StatefulWidget {
  final int compartmentId;

  const CompartmentDetailScreen({Key? key, required this.compartmentId})
      : super(key: key);

  @override
  _CompartmentDetailScreenState createState() =>
      _CompartmentDetailScreenState();
}

class _CompartmentDetailScreenState extends State<CompartmentDetailScreen> {
  late CompartmentModel compartmentModel;
  List<TeacherModel> teachers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.PT_COMPARTMENT),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteCompartmentModel();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CompartmentAddEditScreen(
                  compartmentModel: compartmentModel,
                ),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Text(
                    compartmentModel.compartmentTitle,
                    style: TextStyle(color: Colors.blue.shade50, fontSize: 22),
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.grey.shade300,
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black26,
                      ),
                      onPressed: () {
                        teacherDialog();
                      },
                      label: const Text(
                        "Lehrer hinzufügen",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: buildTeacherList())
                ],
              ),
      )),
    );
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    compartmentModel =
        await DatabaseHelper.db.getCompartmentById(widget.compartmentId);
    teachers = await DatabaseHelper.db
        .getAssignedTeachersFromCompartment(compartmentModel);
    setState(() {
      isLoading = false;
    });
  }

  Future _deleteCompartmentModel() async {
    await DatabaseHelper.db.deleteCompartment(compartmentModel);
  }

  void teacherDialog() async {
    await showDialog(
      context: context,
      builder: (context) => _teacherDialog(),
    );
    refresh();
  }

  Widget buildTeacherList() => ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.blueGrey,
          child: ListTile(
            enabled: true,
            title: Center(
              child: Text(
                teachers[index].name,
                style: TextStyle(
                  color: Colors.brown.shade50,
                  fontSize: 20,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                deleteTCAEntry(index);
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      });

  void deleteTCAEntry(index) async {
    int i = await DatabaseHelper.db
        .deleteTCAByIds(compartmentModel.compartmentId!, teachers[index].id!);
    print("deleted: $i");
    refresh();
  }

  Widget _teacherDialog() {
    return AlertDialog(
      title: const Text("Lehrer hinzufügen"),
      content: DynamicTeacherWidget(
        compartmentModel: compartmentModel,
      ),
    );
  }
}
