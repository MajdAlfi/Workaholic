import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

Future<void> checkDay(int counter, BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  if (counter == null) {
    Provider.of<dataProvider>(context, listen: false).changeTheDay(1);
    prefs.setInt('counter', counter);
  } else if (counter == 7) {
    Provider.of<dataProvider>(context, listen: false).changeTheDay(1);
    prefs.setInt('counter', counter);
  } else if (counter > 7) {
    Provider.of<dataProvider>(context, listen: false).changeTheDay(1);
    prefs.setInt('counter', 1);
  } else {
    if (counter != null) {
      Provider.of<dataProvider>(context, listen: false)
          .changeTheDay(counter + 1);
      prefs.setInt('counter', counter + 1);
    }
  }
}
