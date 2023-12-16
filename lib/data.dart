import 'package:fluter_practice/arg.dart';
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

List Klist = [];

class SqlHelper {
  final String db_path;
  SqlHelper({
    //build up the instance
    required this.db_path,
  });
  ClearDataBase() async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    database.delete('words');
  }

  SaveWord(String KeyWord) async {
    if (KeyWord == "") {
      print("Box is empty");
    } else {
      String path = join(await getDatabasesPath(), db_path);
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) {
          return database.execute('CREATE TABLE Words (keyword TEXT)');
        },
      );
      List list = Arguments.VocabularyList;
      print(KeyWord);
      if (list.every((element) => element.toString() != KeyWord.toString()) ==
          true) {
        print(list.every((element) => element != KeyWord));
        Kw kw = new Kw(keyword: KeyWord);
        database.insert('words', kw.toMap()); //insert the word
        print("current content in the vocabulary");
        print(await ReadOut());
        Arguments.VocabularyList = await ReadOut();
        //database.close();
      } else {
        print('element has already exists');
        //database.close();
      } //close the database
    }
  }

  RemoveWord(String KeyWord) async {
    if (KeyWord == "") {
      print("Box is empty");
    } else {
      String path = join(await getDatabasesPath(), db_path);
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) {
          return database.execute('CREATE TABLE Words (keyword TEXT)');
        },
      );
      database.delete('words', where: 'keyword=?', whereArgs: [KeyWord]);
    }
  }

  Future<List<Kw>> ReadOut() async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    final List<Map<String, dynamic>> maps = await database.query('words');
    return List.generate(maps.length, (i) {
      return Kw(keyword: maps[i]['keyword']);
    });
  }
}

class Kw {
  final String keyword;
  const Kw({
    required this.keyword,
  });
  factory Kw.fromMap(Map<String, dynamic> json) => new Kw(
      keyword: json[
          'json']); // Convert a Dog into a Map. The keys must correspond to the names of the
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

class SqlHelpera {
  final String db_path;
  SqlHelpera({
    //build up the instance
    required this.db_path,
  });
  ClearDataBase() async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    database.delete('words');
  }

  SaveWord(String KeyWord) async {
    if (KeyWord == "") {
      print("Box is empty");
    } else {
      String path = join(await getDatabasesPath(), db_path);
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) {
          return database.execute('CREATE TABLE Words (keyword TEXT)');
        },
      );
      List list = SentenceList;
      print(KeyWord);
      if (list.every((element) => element.toString() != KeyWord.toString()) ==
          true) {
        print(list.every((element) => element != KeyWord));
        Kw kw = new Kw(keyword: KeyWord);
        database.insert('words', kw.toMap()); //insert the word
        print("current content in the vocabulary");
        print(await ReadOut());
        Arguments.VocabularyList = await ReadOut();
        //database.close();
      } else {
        print('element has already exists');
        //database.close();
      } //close the database
    }
  }

  RemoveWord(String KeyWord) async {
    if (KeyWord == "") {
      print("Box is empty");
    } else {
      String path = join(await getDatabasesPath(), db_path);
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (database, version) {
          return database.execute('CREATE TABLE Words (keyword TEXT)');
        },
      );
      database.delete('words', where: 'keyword=?', whereArgs: [KeyWord]);
    }
  }

  Future<List<Kw>> ReadOut() async {
    String path = join(await getDatabasesPath(), db_path);
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        return database.execute('CREATE TABLE Words (keyword TEXT)');
      },
    );
    final List<Map<String, dynamic>> maps = await database.query('words');
    return List.generate(maps.length, (i) {
      return Kw(keyword: maps[i]['keyword']);
    });
  }
}

class Kwa {
  final String keyworda;
  const Kwa({
    required this.keyworda,
  });
  factory Kwa.fromMap(Map<String, dynamic> json) => new Kwa(
      keyworda: json[
          'json']); // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'keyword': keyworda,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return '$keyworda';
  }
}
