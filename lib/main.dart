import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PreScreen());
}

Future init() async{
  //TODO: Prüfen ob das erste Mal gestartet wird
}

class PreScreen extends StatefulWidget {
  const PreScreen({Key? key}) : super(key: key);

  @override
  _PreScreenState createState() => _PreScreenState();
}

class _PreScreenState extends State<PreScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
        ),
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text("ClassControl Personal DEBUG"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Constants.CLASSCONTROL_ICON_PATH),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
