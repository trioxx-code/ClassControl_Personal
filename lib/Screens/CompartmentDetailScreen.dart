/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/CompartmentModel.dart';
import 'package:classcontrol_personal/Screens/CompartmentAddEditScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class CompartmentDetailScreen extends StatefulWidget {
  CompartmentModel compartmentModel;

  CompartmentDetailScreen({Key? key, required this.compartmentModel})
      : super(key: key);

  @override
  _CompartmentDetailScreenState createState() =>
      _CompartmentDetailScreenState();
}

class _CompartmentDetailScreenState extends State<CompartmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.PT_COMPARTMENT),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _deleteCompartmentModel();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CompartmentAddEditScreen(
                  compartmentModel: widget.compartmentModel,
                ),
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          widget.compartmentModel.compartmentTitle,
          style: TextStyle(color: Colors.blue.shade50, fontSize: 16),
        ),
      )),
    );
  }

  Future _deleteCompartmentModel() async {
    await DatabaseHelper.db.deleteCompartment(widget.compartmentModel);
  }
}
