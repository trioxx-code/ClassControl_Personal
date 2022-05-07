/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import '../Modules/TaskModule/TaskModel.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.taskModel, required this.index})
      : super(key: key);

  final TaskModel taskModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = Misc.lightColors[index % Misc.lightColors.length];
    return Card(
        color: color,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Misc.alignedTextItem(
                        Alignment.centerLeft,
                        Misc.convertEpochToString(taskModel.taskDateTime),
                        Colors.grey.shade700),
                    Misc.alignedIconItem(
                        Alignment.center,
                        //taskModel.isChecked? "Erledigt" : "Unerledigt",
                        taskModel.isChecked
                            ? Icons.verified_rounded
                            : Icons.warning_amber_rounded,
                        Colors.black),
                    Misc.alignedTextItem(
                        Alignment.centerRight,
                        taskModel.taskPriority.toString(),
                        Colors.grey.shade700),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  taskModel.taskTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
        ));
  }
}
