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
class VocabularyState extends ChangeNotifier{
  List list =sqlHelper.ReadOut();
}
class vocabulary extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var VocabularyState=context.watch<VocabularyState>;
    // TODO: implement build
    return ChangeNotifierProvider(child: MaterialApp(home: Scaffold(body: Column(children: [],)),));
    throw UnimplementedError();
  }
}