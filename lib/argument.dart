import 'package:sqflite/sqflite.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'connect.dart';

class Arguments {
  static String message = "";
  static int istapped = 0;
  static int counter = 0;
  static String SeverAddress = "ws://45.32.29.121:5678";
  //static String SeverAddress = "ws://192.168.1.21:8765";
  static String? CurrentWord;
  static String database_path = 'save.db';
  static bool isDatasetExits = false;
  static List VocabularyList = [];
  static bool iswaitingreply = false;
  //SeverConnect sc = new SeverConnect();
}
