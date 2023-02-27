import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

checkIfUpgradable(BuildContext context, uid) async {
  var level = context.read<dataProvider>().theLevel.toString();
  int streak = int.parse(context.read<dataProvider>().theStreak.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  FirebaseFirestore fire = FirebaseFirestore.instance;
  if (int.parse(level.substring(3).toString()) == 1) {
    if (streak >= 60) {
      fire
          .collection('Users')
          .doc(uid)
          .update({'Level': int.parse('${level.substring(0, 3)}3')});
      prefs.setInt('Level', int.parse('${level.substring(0, 3)}3'));
      Provider.of<dataProvider>(context, listen: false)
          .uploadLevel(int.parse('${level.substring(0, 3)}3'));
      print('upgrade level 1 to 3');

      prefs.setInt('where', 1);
      showAlertDialog(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog(context,
          'You have to reach 60 or more streak score to upgrade your program!');
    }
  } else if (int.parse(level.substring(3).toString()) == 2) {
    if (streak >= 30) {
      fire
          .collection('Users')
          .doc(uid)
          .update({'Level': int.parse('${level.substring(0, 3)}3')});
      prefs.setInt('Level', int.parse('${level.substring(0, 3)}3'));
      Provider.of<dataProvider>(context, listen: false)
          .uploadLevel(int.parse('${level.substring(0, 3)}3'));
      prefs.setInt('where', 2);
      showAlertDialog(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog(context,
          'You have to reach 30 or more streak score to upgrade your program!');
    }
  } else if (int.parse(level.substring(3).toString()) == 3) {
    if (prefs.getInt('where') != null) {
      if (int.parse(prefs.getInt('where').toString()) == 1) {
        if (streak >= 90) {
          fire
              .collection('Users')
              .doc(uid)
              .update({'Level': int.parse('${level.substring(0, 3)}5')});
          prefs.setInt('Level', int.parse('${level.substring(0, 3)}5'));
          Provider.of<dataProvider>(context, listen: false)
              .uploadLevel(int.parse('${level.substring(0, 3)}5'));
          showAlertDialog(context,
              'Upgraded successfully please restart the app to see the new Program!');
        } else {
          showAlertDialog(context,
              'You have to reach 90 or more streak score to upgrade your program!');
        }
      } else if (int.parse(prefs.getInt('where').toString()) == 2) {
        if (streak >= 60) {
          fire
              .collection('Users')
              .doc(uid)
              .update({'Level': int.parse('${level.substring(0, 3)}5')});
          prefs.setInt('Level', int.parse('${level.substring(0, 3)}5'));
          Provider.of<dataProvider>(context, listen: false)
              .uploadLevel(int.parse('${level.substring(0, 3)}5'));
          showAlertDialog(context,
              'Upgraded successfully please restart the app to see the new Program!');
        } else {
          showAlertDialog(context,
              'You have to reach 60 or more streak score to upgrade your program!');
        }
      }
    } else {
      if (streak >= 30) {
        fire
            .collection('Users')
            .doc(uid)
            .update({'Level': int.parse('${level.substring(0, 3)}5')});
        prefs.setInt('Level', int.parse('${level.substring(0, 3)}5'));
        Provider.of<dataProvider>(context, listen: false)
            .uploadLevel(int.parse('${level.substring(0, 3)}5'));
        showAlertDialog(context,
            'Upgraded successfully please restart the app to see the new Program!');
      } else {
        showAlertDialog(context,
            'You have to reach 30 or more streak score to upgrade your program!');
      }
    }
  } else if (int.parse(level.substring(3).toString()) == 4) {
    if (streak >= 20) {
      fire
          .collection('Users')
          .doc(uid)
          .update({'Level': int.parse('${level.substring(0, 3)}5')});
      prefs.setInt('Level', int.parse('${level.substring(0, 3)}5'));
      Provider.of<dataProvider>(context, listen: false)
          .uploadLevel(int.parse('${level.substring(0, 3)}5'));
      showAlertDialog(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog(context,
          'You have to reach 20 or more streak score to upgrade your program!');
    }
  } else {
    showAlertDialog(context, 'You are already at the pro level champ!!!');
  }
}
