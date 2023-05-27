import 'package:sqflite/sqflite.dart';

class Arguments {
  static String message = "";
  static int istapped = 0;
  static int counter = 0;
  static String SeverAddress = "ws://139.180.146.42:8765";
  //static String SeverAddress = "ws://192.168.124.7:8765";
  static String? CurrentWord;
  static String database_path = 'save.db';
  static bool isDatasetExits = false;
}
