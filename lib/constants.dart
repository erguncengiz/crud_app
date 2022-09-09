import 'package:flutter/material.dart';

// Global parameters
String appBarTitle = "CRUD APP";
String baseUrl = "https://631b3c32fae3df4dcff8cbd2.mockapi.io/api";

// Enums
enum PageState { loading, error, done }

// Constant variables
class Constants {
  static var color = _Colors();
  static var textStyle = _TextStyles();
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
