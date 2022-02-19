/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'package:classcontrol_personal/Models/LearningItemModel.dart';
import 'package:classcontrol_personal/Models/LearningStackModel.dart';
import 'package:classcontrol_personal/Screens/LearningItemAddEditScreen.dart';
import 'package:classcontrol_personal/Screens/LearningItemDetailScreen.dart';
import 'package:classcontrol_personal/Util/Constants.dart';
import 'package:classcontrol_personal/Util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class LearningItemPage extends StatefulWidget {
  const LearningItemPage({Key? key, required this.learningStackModel})
      : super(key: key);
  final LearningStackModel learningStackModel;

  @override
  _LearningItemPageState createState() => _LearningItemPageState();
}

class _LearningItemPageState extends State<LearningItemPage> {
  bool isLoading = false;
  List<LearningItemModel> items = [];
  LearningItemModel? item;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text(Constants.PT_LEARNING),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : items.isEmpty
                    ? const Text(Constants.NO_DATA,
                        style: TextStyle(color: Colors.white, fontSize: 24))
                    : buildItems()),
      ),
    );
  }

  Widget buildItems() {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(items[index].content),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteItem(items[index]),
              ),
              leading: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editItem(),
              ),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LearningItemDetailScreen(
                    learningItemModel: items[index],
                    learningStackModel: widget.learningStackModel,
                  ),
                ));
                refresh();
              },
            ));
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    items = await DatabaseHelper.db
        .getAllLearningItemsByStack(widget.learningStackModel);
    setState(() {
      isLoading = false;
    });
  }

  Future _editItem() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LearningItemAddEditScreen(
        learningStackModel: widget.learningStackModel,
        learningItemModel: item,
      ),
    ));
    await refresh();
  }

  Future _deleteItem(LearningItemModel model) async {
    await DatabaseHelper.db.deleteLearningItemModel(model);
    await refresh();
  }
}
