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
void SaveWord(String word) async{
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db,version){
        return db.execute('CREATE TABLE words(id INTEGER PRIMARY KEY,wordTEXT)',);
      },
      version:1
  );
  Future<void> insertWord(Word word) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'words',
      word.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
   var Inword=Word(word: word);
  insertWord(Inword);
}
class Word{

  final String word;
  const Word({

    required this.word,
  });
  Map<String, dynamic> toMap() {
    return {

      'word': word,
    };
  }
  @override
  String toString() {
    return 'Dog{ word: $word}';
  }
}
// Define a function that inserts dogs into the database
