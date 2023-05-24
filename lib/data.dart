import 'package:fluter_practice/structure.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

import 'MessageSend.dart';
import 'argument.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class SqlHelper {
  final String db_path;
  SqlHelper({
    //build up the instance
    required this.db_path,
  });
  Opericate(String KeyWord) async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    var value = {'keyword': KeyWord};
    database.insert('words', value); //insert the word
    database.close(); //close the database
  }

  ReadOut() async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    print("get");
    final maps = await database.query('words');
    print(maps.toList());
  }
}
