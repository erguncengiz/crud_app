import 'package:flutter/material.dart';

// Global parameters
String appBarTitle = "CRUD APP";

// Enums
enum PageState { loading, error, done }

enum ExecutionType { delete, update }

// Constant variables
class Constants {
  static var color = _Colors();
  static var textStyle = _TextStyles();
  static var keys = _SharedPrefsKeys();
}

class _Colors {
  Color themeColor = const Color.fromARGB(255, 26, 10, 67);
}

class _TextStyles {
  TextStyle blackBold = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle blackRegular = const TextStyle(color: Colors.black, fontSize: 18);
  TextStyle whiteBold = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle whiteRegular = const TextStyle(color: Colors.white, fontSize: 18);
}

class _SharedPrefsKeys {
  String savedPageIndex = "SAVED_PAGE_INDEX";
}
