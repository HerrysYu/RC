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
  Opericate(String KeyWord, String Content) async {
    if (databaseExists(db_path) == true) {
//do something
      print('database exists');
      Database database = await openDatabase(db_path);
      var value = {'keyword': KeyWord, 'content': Content};
      database.insert('words', value); //insert the word
      database.close(); //close the database
    } else {
//create the table
      String path = join(await getDatabasesPath(), db_path);
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE Words (keyword TEXT, content TEXT)'); //create the database
        var value = {'keyword': KeyWord, 'content': Content};
        db.insert('words', value); //insert words
        db.close(); //close the database
        print("word" + KeyWord.toString());
        print(Content);
      });
    }
  }
}
