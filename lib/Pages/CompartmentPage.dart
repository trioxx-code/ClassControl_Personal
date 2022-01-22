/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Screens/CompartmentAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class CompartmentPage extends StatefulWidget {
  const CompartmentPage({Key? key}) : super(key: key);

  @override
  _CompartmentPageState createState() => _CompartmentPageState();
}

class _CompartmentPageState extends State<CompartmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompartmentAddEditScreen(),
          ));
        },
      ),
      appBar: AppBar(
        title: const Text(Constants.PT_COMPARTMENT),
      ),
      body: Container(),
    );
  }
}
