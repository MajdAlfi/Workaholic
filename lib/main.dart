import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Screens/Auth/Forgot.dart';
import 'package:workout_app/src/Screens/Auth/Login.dart';
import 'package:workout_app/src/Services/dataProvider.dart';
import 'src/Screens/Auth/Signup.dart';
import 'src/Screens/Data/DataCollector1.dart';
import 'src/Screens/Data/DataCollector2.dart';
import 'src/Screens/interface/Settings.dart';
import 'src/Screens/interface/Videos_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool userStatus = prefs.containsKey('uid');
  Widget Home;
  if (userStatus == true) {
    Home = vids();
  } else {
    Home = Login();
  }

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => dataProvider())],
      child: MaterialApp(routes: {
        '/First': (context) => MyApp(),
        '/Second': (context) => DataCollector2(),
        '/vids': (context) => vids(),
        '/settings': (context) => Settings(),
        '/Signup': (context) => Signup(),
        '/Login': (context) => Login(),
        '/Forgot': (context) => forgot(),
      }, home: Home)));
}
