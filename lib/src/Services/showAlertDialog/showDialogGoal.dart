import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

showAlertDialogGoal(BuildContext context, uid) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      var Goal = [
        "Select your Goal",
        "Body Building",
        "Weight Loss",
        "Maintain Body Weight"
      ].map<DropdownMenuItem<String>>((String limitX) {
        return DropdownMenuItem(
            child: Text(
              limitX,
              style: TextStyle(color: Colors.white),
            ),
            value: limitX);
      }).toList();
      var DefaultG = "Select your Goal";

      return CupertinoAlertDialog(
        title: Text("Goal Change"),
        content: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          child: Container(
              width: widthScr(context, 80),
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
                    items: Goal,
                    hint: Text("Select your Goal"),
                    value: DefaultG,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    dropdownColor: gr(),
                    onChanged: (String? newValue) async {
                      if (await checkInternetConnection() == true) {
                        DefaultG = newValue!;
                        var level =
                            context.read<dataProvider>().theLevel.toString();
                        if (DefaultG != 'Select your Goal' &&
                            DefaultG != context.read<dataProvider>().theGoal) {
                          await fire
                              .collection('Users')
                              .doc(uid)
                              .update({'Goal': DefaultG});
                          Provider.of<dataProvider>(context, listen: false)
                              .updateGoal(DefaultG);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (DefaultG == 'Body Building') {
                            fire.collection('Users').doc(uid).update({
                              'Level': int.parse(
                                  '${level.substring(0, 2)}1${level.substring(3)}')
                            });
                            prefs.setInt(
                                'Level',
                                int.parse(
                                    '${level.substring(0, 2)}1${level.substring(3)}'));
                            Provider.of<dataProvider>(context, listen: false)
                                .uploadLevel(int.parse(
                                    '${level.substring(0, 2)}1${level.substring(3)}'));
                          } else if (DefaultG == 'Weight Loss') {
                            fire.collection('Users').doc(uid).update({
                              'Level': int.parse(
                                  '${level.substring(0, 2)}2${level.substring(3)}')
                            });
                            prefs.setInt(
                                'Level',
                                int.parse(
                                    '${level.substring(0, 2)}2${level.substring(3)}'));
                            Provider.of<dataProvider>(context, listen: false)
                                .uploadLevel(int.parse(
                                    '${level.substring(0, 2)}2${level.substring(3)}'));
                          } else {
                            fire.collection('Users').doc(uid).update({
                              'Level': int.parse(
                                  '${level.substring(0, 2)}3${level.substring(3)}')
                            });
                            prefs.setInt(
                                'Level',
                                int.parse(
                                    '${level.substring(0, 2)}3${level.substring(3)}'));
                            Provider.of<dataProvider>(context, listen: false)
                                .uploadLevel(int.parse(
                                    '${level.substring(0, 2)}3${level.substring(3)}'));
                          }
                          print(prefs.getInt('Level'));
                          Provider.of<dataProvider>(context, listen: false)
                              .uploadLevel(
                                  int.parse(prefs.getInt('Level').toString()));
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pop();
                          showAlertDialog(context, 'Please select a new Value');
                        }
                      } else {
                        Navigator.pop(context);
                        showAlertDialog(context,
                            'Please Connect to the intenet to update data');
                      }
                    }),
              )),
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
