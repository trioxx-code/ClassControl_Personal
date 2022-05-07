/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */

import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'LearningItemModel.dart';
import '../LearningStack/LearningStackModel.dart';
import 'LearningItemAddEditScreen.dart';
import 'LearningItemDetailScreen.dart';
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

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LearningItemAddEditScreen(
                learningStackModel: widget.learningStackModel),
          ));
          await refresh();
        },
      ),
      appBar: AppBar(
        title: Text(widget.learningStackModel.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : items.isEmpty
                  ? const Text(Constants.NO_DATA,
                      style: TextStyle(color: Colors.white, fontSize: 24))
                  : buildItems()),
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
                onPressed: () => _editItem(items[index]),
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

  Future _editItem(LearningItemModel item) async {
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
