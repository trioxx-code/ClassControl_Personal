/*
 * Copyright (c) 2021. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
    //TODO: SharedPreferences verwenden um URL zu bekommen
  }
//@info: https://pub.dev/packages/webview_flutter
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_WEB),
        actions: [
          TextButton(
            child: const Text("URL"),
            onPressed: () {
              //TODO: Popup für URL
            },
          )
        ],
      ),
      body: Container(),
    );
  }

  void storeUrl(String url) {}

  String? getUrl() {
    return "";
  }
}
