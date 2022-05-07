/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'TaskModel.dart';
import 'TaskAddEditScreen.dart';
import 'TaskDetailScreen.dart';
import 'package:classcontrol_personal/Widgets/TaskCardWidget.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideDrawer(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TaskAddEditScreen(),
            ));
            refresh();
          },
        ),
        appBar: AppBar(
          title: const Text(Constants.PT_TASK),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : tasks.isEmpty
                  ? const Text(Constants.NO_DATA,
                      style: TextStyle(color: Colors.white, fontSize: 24))
                  : buildTasks(),
        ));
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    tasks = await DatabaseHelper.db.getAllTasks();
    setState(() {
      isLoading = false;
    });
  }

  Widget buildTasks() => ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) => ListTile(
            //isThreeLine: true,
            title: TaskCardWidget(
              taskModel: tasks[index],
              index: index,
            ),
            leading: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editTask(tasks[index]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(tasks[index]),
            ),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TaskDetailScreen(
                  taskModel: tasks[index],
                ),
              ));
              refresh();
            },
          ));

  Future _deleteTask(TaskModel model) async {
    await DatabaseHelper.db.deleteTask(model);
    await refresh();
  }

  Future _editTask(TaskModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TaskAddEditScreen(
        taskModel: model,
      ),
    ));
    await refresh();
  }
}
