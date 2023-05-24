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
    Arguments.database_path = db_path;
    if (databaseExists(db_path) == true) {
//do something
      print('database exists');
      Database database = await openDatabase(db_path);
      var value = {'keyword': KeyWord};
      database.insert('words', value); //insert the word
      database.close(); //close the database
    } else {
//create the table
      String path = join(await getDatabasesPath(), db_path);
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) {
        db.execute('CREATE TABLE Words (keyword TEXT)'); //create the database
        var value = {'keyword': KeyWord};
        db.insert('words', value); //insert words
        db.close(); //close the database
        Arguments.isDatasetExits = true;
      });
    }
  }

  ReadOut() async {
    if (databaseExists(db_path) == true) {
      //read out
      Database database = await openDatabase(db_path);
      final map = await database.query("words");
      print(map);
    } else {
      print("database isnt't exits");
    }
  }
}

void DBinitialize() async {
  if (databaseExists(Arguments.database_path) == true) {
//do something
    Arguments.isDatasetExits = true;
    print("database exists");
  } else {
    String path = join(await getDatabasesPath(), Arguments.database_path);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute('CREATE TABLE Words (keyword TEXT)');
    });
    database.close();
    Arguments.isDatasetExits = true;
  }
}
