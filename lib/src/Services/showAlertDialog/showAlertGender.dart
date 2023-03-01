import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

showAlertDialogGender(BuildContext context, uid) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      var Gender = ["Select your Gender", "Male", "Female"]
          .map<DropdownMenuItem<String>>((String limitX) {
        return DropdownMenuItem(
            child: Text(
              limitX,
              style: TextStyle(color: Colors.white),
            ),
            value: limitX);
      }).toList();
      var DefaultG = "Select your Gender";

      return CupertinoAlertDialog(
        title: Text("Gender Change"),
        content: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: widthScr(context, 85),
                height: 50,
                decoration: BoxDecoration(
                    color: gr(),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      iconEnabledColor: Colors.white,
                      items: Gender,
                      hint: Text("Select your Gender"),
                      value: DefaultG,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      dropdownColor: gr(),
                      onChanged: (String? newValue) async {
                        if (await checkInternetConnection() == true) {
                          DefaultG = newValue!;
                          var level =
                              context.read<dataProvider>().theLevel.toString();
                          if (DefaultG != 'Select your Gender' &&
                              DefaultG !=
                                  context.read<dataProvider>().theGender) {
                            await fire
                                .collection('Users')
                                .doc(uid)
                                .update({'Gender': DefaultG});
                            Provider.of<dataProvider>(context, listen: false)
                                .updateGender(DefaultG);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (DefaultG == 'Male') {
                              fire.collection('Users').doc(uid).update({
                                'Level': int.parse(
                                    '${level.substring(0, 1)}1${level.substring(2)}')
                              });
                              prefs.setInt(
                                  'Level',
                                  int.parse(
                                      '${level.substring(0, 1)}1${level.substring(2)}'));
                              Provider.of<dataProvider>(context, listen: false)
                                  .uploadLevel(int.parse(
                                      '${level.substring(0, 1)}1${level.substring(2)}'));
                            } else {
                              fire.collection('Users').doc(uid).update({
                                'Level': int.parse(
                                    '${level.substring(0, 1)}2${level.substring(2)}')
                              });
                              prefs.setInt(
                                  'Level',
                                  int.parse(
                                      '${level.substring(0, 1)}2${level.substring(2)}'));
                              Provider.of<dataProvider>(context, listen: false)
                                  .uploadLevel(int.parse(
                                      '${level.substring(0, 1)}2${level.substring(2)}'));
                            }
                            print(prefs.getInt('Level'));

                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                            showAlertDialog(
                                context, 'Please select a new Value');
                          }
                        } else {
                          Navigator.pop(context);
                          showAlertDialog(context,
                              'Please Connect to the intenet to update data');
                        }
                      }),
                )),
          ),
        ),
        actions: [
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
