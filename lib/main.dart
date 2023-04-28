import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';
import 'package:workout_app/src/Screens/Auth/Forgot.dart';
import 'package:workout_app/src/Screens/Auth/Login.dart';
import 'package:workout_app/src/Screens/interface/Admin.dart';
import 'package:workout_app/src/Screens/interface/noInternet.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Notifications/NotiicationInIt.dart';
import 'package:workout_app/src/Services/Notifications/setup.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'src/Screens/Auth/Signup.dart';
import 'src/Screens/Data/DataCollector1.dart';
import 'src/Screens/Data/DataCollector2.dart';
import 'src/Screens/interface/Settings.dart';
import 'src/Screens/interface/Videos_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool userStatus = prefs.containsKey('uid');
  prefs.setString(
      'notDate', DateTime.now().add(Duration(seconds: 10)).toString());
  await setup();
  tz.initializeTimeZones();

  Widget Home;
  if (userStatus == true) {
    Home = (await checkInternetConnection() == true) ? vids() : noInternet();
  } else {
    Home = Login();
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => dataProvider()),
      ],
      child: MaterialApp(routes: {
        '/First': (context) => MyApp(),
        '/Second': (context) => DataCollector2(),
        '/vids': (context) => vids(),
        '/settings': (context) => Settings(),
        '/Signup': (context) => Signup(),
        '/Login': (context) => Login(),
        '/Forgot': (context) => forgot(),
        '/admin': (context) => admin(),
      }, home: Home)));
}
