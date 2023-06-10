import 'package:fluter_practice/data.dart';
import 'package:fluter_practice/main.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';
import 'MessageSend.dart';
import 'argument.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

class VocabularyState extends ChangeNotifier {
  List list = Arguments.VocabularyList;
  ListRefresh() async {
    list = await sqlHelper.ReadOut();
    notifyListeners();
  }
}

final VocabularyState vocabularyState = VocabularyState();

class VList extends StatelessWidget {
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var state = context.watch<VocabularyState>();
    List list = state.list;
    return Column(
      key: _key,
      children: [
        for (var key in list)
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              alignment: Alignment.topLeft,
              //margin: EdgeInsets.only(left: 30, bottom: 5, top: 20),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.only(left: 30, bottom: 20, top: 20),
                    primary: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.white,
                    side: BorderSide(color: Colors.white)),
                child: Text(
                  key.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.left,
                ),
                onPressed: (() {
                  //Search(key);
                  print("$key tapped");
                  Navigator.pop(context);
                  tec.text = key.toString();
                }),
                onLongPress: () {
                  print("$key LongPressed");
                  sqlHelper.RemoveWord(key.toString());
                  state.ListRefresh();
                },
              ),
            ),
          )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class vocabulary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => VocabularyState(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CustomScrollView(slivers: [
            Bar(),
            SliverToBoxAdapter(
              child: Container(
                child: VList(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class ScroolView extends StatelessWidget {
  const ScroolView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [Bar(), VList()],
    );
  }
}

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    var State = context.watch<VocabularyState>();
    return SliverAppBar(
      expandedHeight: 150,
      key: _key,
      backgroundColor: Color.fromARGB(255, 248, 240, 243),
      flexibleSpace: FlexibleSpaceBar(
          title: Container(
        margin: EdgeInsets.all(32),
        child: Text(
          "AppBar",
          style: TextStyle(color: Colors.black),
        ),
      )),
      stretch: true,
      //onStretchTrigger: State.ListRefresh(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
