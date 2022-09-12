import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.prod';
    } else {
      if (kDebugMode) {
        return '.env.test';
      } else {
        return '.env.uat';
      }
    }
  }

  static String get apiBaseUrl {
    return dotenv.env['apiBaseUrl'] ?? "API NOT FOUND!";
  }
}
