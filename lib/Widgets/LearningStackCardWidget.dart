/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Models/LearningStackModel.dart';
import 'package:classcontrol_personal/Util/Misc.dart';
import 'package:flutter/material.dart';

class LearningStackCardWidget extends StatelessWidget {
  const LearningStackCardWidget(
      {Key? key,
      required this.learningStackModel,
      required this.index,
      required this.onPressed})
      : super(key: key);
  final int index;
  final LearningStackModel learningStackModel;
  final onPressed;

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
                    Misc.alignedTextItem(Alignment.centerLeft,
                        learningStackModel.title, Colors.black,
                        fontSize: 20, fontWeight: FontWeight.bold),
                    Misc.alignedTextButtonItem(Alignment.centerRight,
                        "Items anzeigen", Colors.white, onPressed,
                        fontSize: 20,
                        buttonStyle: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black))),
                  ],
                ),
                const SizedBox(height: 4),
              ]),
        ));
  }
}
