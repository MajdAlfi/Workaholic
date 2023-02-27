import 'package:flutter/material.dart';
import 'package:workout_app/src/Services/Others/color.dart';

Color ButtonColor(prefs) {
  if (prefs.getBool('bool') == true) {
    return gr();
  } else {
    return Colors.grey;
  }
}
