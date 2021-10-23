import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PreScreen());
}

class PreScreen extends StatefulWidget {
  @override
  _PreScreenState createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text("ClassControl Personal DEBUG"),
        ),
        body: Container(

        ),
      ),
    );
  }
}
