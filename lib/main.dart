import 'package:flutter/material.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:workout_app/Screens/Auth/Login.dart';
import 'Screens/Auth/Signup.dart';
import 'Screens/Data/DataCollector1.dart';
import 'Screens/Data/DataCollector2.dart';
import 'Screens/Settings.dart';
import 'Screens/Videos_preview.dart';

void main() {
  runApp(MaterialApp(routes: {
    '/First': (context) => MyApp(),
    '/second': (context) => DataCollector2(),
    '/vids': (context) => vids(),
    '/settings': (context) => Settings(),
    '/Signup': (context) => Signup(),
    '/Login': (context) => Login(),
  }, home: Login()));
}
