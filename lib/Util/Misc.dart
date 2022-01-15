/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

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

}