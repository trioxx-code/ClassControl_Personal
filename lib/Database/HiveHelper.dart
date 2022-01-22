/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

//TODO: Hive implementieren für die Notizen. In Kombi mit flutter_quill
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future initHive() async {
    await Hive.initFlutter();
  }

//static Box getClasses() => Hive.box(Constants.HIVE_STUDY_CLASS);
//static Box getStacks() => Hive.box(Constants.HIVE_STACK);

}
