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
  SaveWord(String KeyWord) async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    List list = await ReadOut();
    print(KeyWord);
    if (list.every((element) => element.toString() != KeyWord.toString()) ==
        true) {
      print(list.every((element) => element != KeyWord));
      var value = {'keyword': KeyWord};
      database.insert('words', value); //insert the word
      database.close();
    } else {
      print('element has already exists');
    } //close the database
  }

  RemoveWord(String KeyWord) async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    List list = await ReadOut();
    print(KeyWord);
    if (list.every((element) => element.toString() != KeyWord.toString()) ==
        true) {
      print(list.every((element) => element != KeyWord));
      var value = {'keyword': KeyWord};
      database.insert('words', value); //insert the word
      database.close();
    } else {
      print('element has already exists');
    } //close the database
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
    final List<Map<String, dynamic>> maps = await database.query('words');
    return List.generate(maps.length, (index) {
      return Kw(keyword: maps[index]['keyword']);
    });
  }
}

class Kw {
  final String keyword;
  const Kw({
    required this.keyword,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return '$keyword';
  }
}
