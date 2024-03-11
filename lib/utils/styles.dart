import 'package:flutter/material.dart' hide Colors;

import 'colors.dart';

class Styles {
  static TextStyle inputFieldsTitle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.primaryColor);

  static TextStyle inputFieldsText =
      TextStyle(fontSize: 13.0, color: Colors.gray);

  static TextStyle SignUpTitle = TextStyle(
      fontSize: 25.0, color: Colors.primaryColor, fontWeight: FontWeight.bold);

  static TextStyle registerTitle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.primaryColor);

  static TextStyle registerButtonText =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white);

  static TextStyle addUsageButtonText =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white);

  static TextStyle urlText = TextStyle(
    fontSize: 11.0,
    color: Colors.gray,
  );

  static TextStyle latestNewsText =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
}
