/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Misc {
  static const String DATE_FORMAT = "dd.MM.yyyy HH:mm";

  static String convertEpochToString(int epoch) {
    var format = DateFormat(DATE_FORMAT);
    var date = DateTime.fromMillisecondsSinceEpoch(epoch);
    return format.format(date);
  }

  static int getCurrentEpochMilli() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static final lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100,
  ];

  static Widget alignedItem(Alignment alignement, String text, Color textColor,
      {double? padding, double? fontSize}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Align(
          alignment: alignement,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontSize ?? 14.0),
          ),
        ),
      ),
    );
  }
}
