/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPreferencesHelper {
 static void saveData(final String key, final String value) async {
  //@info: Anstatt return, einen Standardwert festlegen? --> static standardwert
  if (key.isEmpty) return;
  if (value.isEmpty) return;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value);
 }

 static Future<dynamic> readData(final String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
 }

 static Future<String?> readDataString(final String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(key);
 }

 static Future<int?> readDataInt(final String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getInt(key);
 }

 static void saveSignedInt(final String key, int value) async {
  if (key.isEmpty) return;
  if (value.toString().isEmpty) return;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt(key, value);
 }
}