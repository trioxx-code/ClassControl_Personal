/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'CompartmentModel.dart';
import 'CompartmentAddEditScreen.dart';
import 'CompartmentDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:flutter/material.dart';

class CompartmentPage extends StatefulWidget {
  const CompartmentPage({Key? key}) : super(key: key);

  @override
  _CompartmentPageState createState() => _CompartmentPageState();
}

class _CompartmentPageState extends State<CompartmentPage> {
  bool isLoading = false;
  List<CompartmentModel> compartments = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompartmentAddEditScreen(),
          ));
          refresh();
        },
      ),
      appBar: AppBar(
        title: const Text(Constants.PT_COMPARTMENT),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : compartments.isEmpty
            ? const Text(Constants.NO_DATA,
            style: TextStyle(color: Colors.white, fontSize: 24))
            : buildCompartments(),
      ));
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    compartments = await DatabaseHelper.db.getAllCompartments();
    setState(() {
      isLoading = false;
    });
  }

  Widget buildCompartments() => ListView.builder(
    itemCount: compartments.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => ListTile(
        title: Text(compartments[index].compartmentTitle),
        leading: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _editCompartment(compartments[index]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              _deleteCompartment(compartments[index]),
        ),
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CompartmentDetailScreen(
              compartmentId: compartments[index].compartmentId!,
            ),
          ));
          refresh();
        },
      ));

  Future _deleteCompartment(CompartmentModel model) async {
    await DatabaseHelper.db.deleteCompartment(model);
    await refresh();
  }

  Future _editCompartment(CompartmentModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CompartmentAddEditScreen(
        compartmentModel: model,
      ),
    ));
    await refresh();
  }

}
