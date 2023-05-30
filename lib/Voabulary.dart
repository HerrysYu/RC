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
class VocabularyState extends ChangeNotifier{
  List list =sqlHelper.ReadOut();
  ListRefresh()async{
  list=sqlHelper.ReadOut();
  notifyListeners();
  }
}
final VocabularyState vocabularyState=VocabularyState();
class VList extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    var state=context.watch<VocabularyState>();
    List list=state.list;
    return Column(
      children: [
        //for(var o in list)
          //Text(o)
        Text("Text")
      ]
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class vocabulary extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => VocabularyState(),
     child: Scaffold(body: Hero(tag:'TP',child: Center(child: VList(),)),),
);
  }
  }

class ScroolView extends StatelessWidget {
  const ScroolView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [Bar(),VList()],);
  }
}
  class Bar extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    var State=context.watch<VocabularyState>();
    return SliverAppBar(
      flexibleSpace: const FlexibleSpaceBar(
    title: Text('AppBar'),
  ),
  onStretchTrigger: State.ListRefresh(),
);
    // TODO: implement build
    throw UnimplementedError();
  }
  }
