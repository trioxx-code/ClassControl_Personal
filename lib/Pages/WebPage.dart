import 'package:classcontrol_personal/util/Constants.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.PT_WEB),
      ),
      body: Container(

      ),
    );
  }
}
