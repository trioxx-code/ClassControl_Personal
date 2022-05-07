/*
 * Copyright (c) 2022. ClassControl Personal by trioxx
 */ // ignore_for_file: file_names
import 'package:classcontrol_personal/Database/DatabaseHelper.dart';
import 'LearningStack/LearningStackModel.dart';
import 'LearningItem/LearningItemPage.dart';
import 'LearningStack/LearningStackAddEditScreen.dart';
import 'LearningStack/LearningStackDetailScreen.dart';
import 'package:classcontrol_personal/Widgets/LearningStackCardWidget.dart';
import 'package:classcontrol_personal/util/Constants.dart';
import 'package:classcontrol_personal/util/SideBarDrawer.dart';
import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

//@info: ist LearningStack mit den Items
class _LearningPageState extends State<LearningPage> {
  bool isLoading = false;
  List<LearningStackModel> stacks = [];

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
            builder: (context) => LearningStackAddEditScreen(),
          ));
          await refresh();
        },
      ),
      appBar: AppBar(
        title: const Text(Constants.PT_LEARNING),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : stacks.isEmpty
            ? const Text(Constants.NO_DATA,
            style: TextStyle(color: Colors.white, fontSize: 24))
            : buildStacks(),
      ));
    /*SingleChildScrollView(
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : stacks.isEmpty
                    ? const Text(Constants.NO_DATA,
                        style: TextStyle(color: Colors.white, fontSize: 24))
                    : buildStacks()),
      ),
    );*/
  }

  Widget buildStacks() {
    return ListView.builder(
        itemCount: stacks.length,
        itemBuilder: (context, index) => ListTile(
              title: LearningStackCardWidget(
                learningStackModel: stacks[index],
                index: index,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        LearningItemPage(learningStackModel: stacks[index]),
                  ));
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteStack(stacks[index]),
              ),
              leading: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editStack(stacks[index]),
              ),
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LearningStackDetailScreen(
                    learningStackModel: stacks[index],
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
    stacks = await DatabaseHelper.db.getAllLearningStacks();
    setState(() {
      isLoading = false;
    });
  }

  Future _editStack(LearningStackModel model) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LearningStackAddEditScreen(
        learningStackModel: model,
      ),
    ));
    await refresh();
  }

  Future _deleteStack(LearningStackModel model) async {
    await DatabaseHelper.db.deleteLearningStackModel(model);
    await refresh();
  }
}

//vom ListView.builder
/*ListTile(
        title: Text(stacks[index].title),
        leading: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _editStack(stacks[index]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _deleteStack(stacks[index]),
        ),
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LearningStackDetailScreen(
              learningStackModel: stacks[index],
            ),
          ));
          refresh();
        },
      ),*/
