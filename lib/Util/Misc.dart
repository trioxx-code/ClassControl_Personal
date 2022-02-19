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

  static Widget alignedTextItem(
      Alignment alignement, String text, Color textColor,
      {double? padding,
      double? fontSize,
      FontWeight? fontWeight,
      TextDecoration? textDecoration}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Align(
          alignment: alignement,
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize ?? 14.0,
                fontWeight: fontWeight,
                decoration: textDecoration),
          ),
        ),
      ),
    );
  }

  static Widget alignedIconItem(Alignment alignment, IconData icon, Color color,
      {double? padding}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Align(
          child: Icon(
            icon,
            color: color,
          ),
          alignment: alignment,
        ),
      ),
    );
  }

  static Widget alignedTextButtonItem(
      Alignment alignement, String text, Color textColor, onPressed,
      {double? padding,
      double? fontSize,
      FontWeight? fontWeight,
      TextDecoration? textDecoration,
      ButtonStyle? buttonStyle}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 8.0),
        child: Align(
          alignment: alignement,
          child: TextButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize ?? 14.0,
                  fontWeight: fontWeight,
                  decoration: textDecoration),
            ),
          ),
        ),
      ),
    );
  }
}
