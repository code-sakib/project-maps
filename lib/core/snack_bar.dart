import 'package:flutter/material.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

class Utilis {
  static showSnackBar(errorMsg) {
    if (errorMsg == null) return null;

    final snackBar = SnackBar(
      content: Text(errorMsg),
      backgroundColor: Colors.red[200],
    );

    scaffolfMessengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
