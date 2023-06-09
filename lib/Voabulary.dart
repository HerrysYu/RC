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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                onPrimary: Colors.white,
                shadowColor: Colors.white30,
              ),
              child: Text(key.toString()),
              onPressed: () {},
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
      child: MaterialApp(
        key: _key,
        home: Scaffold(
          body: Center(
            child: CustomScrollView(slivers: [
              Bar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    child: VList(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ]),
          ),
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
      key: _key,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text('AppBar'),
      ),
      stretch: true,
      //onStretchTrigger: State.ListRefresh(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
