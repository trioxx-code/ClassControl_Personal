/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Models/NoteModel.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({Key? key, required this.noteModel, required this.index})
      : super(key: key);

  final NoteModel noteModel;
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
                    Misc.alignedItem(
                        Alignment.centerLeft,
                        Misc.convertEpochToString(noteModel.date),
                        Colors.grey.shade700),
                    Misc.alignedItem(Alignment.centerRight,
                        noteModel.priority.toString(), Colors.grey.shade700),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  noteModel.title,
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
