import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

import '../Others/dataProvider.dart';

showAlertDialogSettings(BuildContext context, String txt, uid) {
  TextEditingController contTxt = TextEditingController();
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("$txt Update"),
        content: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 240, 240, 240)),
            child: TextField(
              controller: contTxt,
              keyboardType: TextInputType.number,
              autofocus: false,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  hintText: "Enter new $txt",
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.transparent),
              cursorColor: Colors.black,
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text("Update"),
              onPressed: () async {
                if (await checkInternetConnection() == true) {
                  var level = context.read<dataProvider>().theLevel.toString();
                  if (contTxt.text != '') {
                    if (txt == 'Age') {
                      if (int.parse(contTxt.text) > 16 &&
                          int.parse(contTxt.text) < 100) {
                        fire
                            .collection('Users')
                            .doc(uid)
                            .update({'$txt': int.parse(contTxt.text)});
                        Provider.of<dataProvider>(context, listen: false)
                            .updateAge(int.parse(contTxt.text));
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (int.parse(contTxt.text) <= 40) {
                          fire.collection('Users').doc(uid).update(
                              {'Level': int.parse('1${level.substring(1)}')});
                          prefs.setInt(
                              'Level', int.parse('1${level.substring(1)}'));
                          Provider.of<dataProvider>(context, listen: false)
                              .uploadLevel(int.parse('1${level.substring(1)}'));
                        } else {
                          fire.collection('Users').doc(uid).update(
                              {'Level': int.parse('2${level.substring(1)}')});
                          prefs.setInt(
                              'Level', int.parse('2${level.substring(1)}'));
                          Provider.of<dataProvider>(context, listen: false)
                              .uploadLevel(int.parse('2${level.substring(1)}'));
                        }
                        print(prefs.getInt('Level'));
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();

                        showAlertDialog(
                            context, 'Please enter a reasonable Age');
                      }
                    } else if (txt == 'Weight') {
                      if (int.parse(contTxt.text) > 0 &&
                          int.parse(contTxt.text) < 250) {
                        fire
                            .collection('Users')
                            .doc(uid)
                            .update({'$txt': int.parse(contTxt.text)});
                        Provider.of<dataProvider>(context, listen: false)
                            .updateWeight(int.parse(contTxt.text));
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        showAlertDialog(
                            context, 'Please enter a reasonable Weight in Kg');
                      }
                    } else if (txt == 'Height') {
                      if (int.parse(contTxt.text) > 0 &&
                          int.parse(contTxt.text) < 250) {
                        fire
                            .collection('Users')
                            .doc(uid)
                            .update({'$txt': int.parse(contTxt.text)});
                        Provider.of<dataProvider>(context, listen: false)
                            .updateHeight(int.parse(contTxt.text));
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        showAlertDialog(
                            context, 'Please enter a reasonable Height in CM');
                      }
                    } else {
                      Navigator.of(context).pop();
                      showAlertDialog(context, 'An error Occured');
                    }
                  } else {
                    Navigator.of(context).pop();
                    showAlertDialog(context, 'Please enter the required data');
                  }
                } else {
                  Navigator.pop(context);
                  showAlertDialog(
                      context, 'Please Connect to the internet to update data');
                }
              }),
          CupertinoDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
