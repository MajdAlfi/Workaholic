import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/SignupSer.dart';
import 'package:workout_app/src/Services/analyze.dart';
import 'package:workout_app/src/Services/dataProvider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    double heightScr = MediaQuery.of(context).size.height;
    double widthScr = MediaQuery.of(context).size.width;
    int? ageProv = context.watch<dataProvider>().theAge;
    int? weightProv = context.watch<dataProvider>().theWeight;
    int? heightProv = context.watch<dataProvider>().theHeight;
    String? genderProv = context.watch<dataProvider>().theGender;
    String? goalProv = context.watch<dataProvider>().theGoal;
    String? expProv = context.watch<dataProvider>().theExperience;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: gr(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                  prefs.remove('uid');
                  prefs.remove('counter');
                  prefs.remove('where');
                  prefs.remove('Level');
                  prefs.remove('Tmr');
                  prefs.remove('bool');
                  prefs.clear();
                  Provider.of<dataProvider>(context, listen: false)
                      .changeTheDay(1);
                  Provider.of<dataProvider>(context, listen: false).deleteAll();
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/Login');
                });
              },
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    "SignOut",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                  color: gr(),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/final.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      radius: 70,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        context.read<dataProvider>().theName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Container(
              height: 400,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: gr()),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                child: Column(
                  children: [
                    Cont('Age', ageProv, context, 'Age Update', 'Age', uid, 15),
                    Cont('Weight', weightProv, context, 'Weight Update',
                        'Weight', uid, 15),
                    Cont('Height', heightProv, context, 'Height Update',
                        'Height', uid, 15),
                    Cont('Gender', genderProv, context, 'Gender Update',
                        'Gender', uid, 15),
                    Cont('Goal', goalProv, context, 'Goal Update', 'Goal', uid,
                        15),
                    Cont('Experience', expProv, context, 'Experience Update',
                        'Experience', uid, 12)
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 20,
            thickness: 5,
            color: gr(),
          ),
          SizedBox(
              width: 300,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      checkIfUpgradable(context, uid);
                    });
                  },
                  child: Text(
                    'Want to UPGRADE into more advanced exercise program?',
                    style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
                  ))),
        ],
      ),
    );
  }
}

Widget Cont(String name, dynamic value, BuildContext context, String x,
    String txt, uid, double size) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$name: $value",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size,
                  color: Colors.white),
            ),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white),
              child: TextButton(
                  onPressed: () {
                    if (name == 'Age' || name == 'Weight' || name == 'Height') {
                      showAlertDialog(context, txt, uid);
                    } else if (name == 'Gender') {
                      showAlertDialogGender(context, uid);
                    } else if (name == 'Goal') {
                      showAlertDialogGoal(context, uid);
                    } else if (name == 'Experience') {
                      //showAlertDialogExp(context, uid);
                      showAlertDialog2(context,
                          "You can't change your Experience Level as it will be considered cheating. for more info contact the developer");
                    }
                  },
                  child: Text("Change")),
            ),
          ],
        ),
      ],
    ),
  );
}

showAlertDialog(BuildContext context, String txt, uid) {
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

                      showAlertDialog2(
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
                      showAlertDialog2(
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
                      showAlertDialog2(
                          context, 'Please enter a reasonable Height in CM');
                    }
                  } else {
                    Navigator.of(context).pop();
                    showAlertDialog2(context, 'An error Occured');
                  }
                } else {
                  Navigator.of(context).pop();
                  showAlertDialog2(context, 'Please enter the required data');
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

showAlertDialog2(BuildContext context, String x) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Alert"),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(x),
        ),
        actions: [
          CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          //  CupertinoDialogAction(
          //    child: Text("NO"),
          //    onPressed: (){
          //      Navigator.of(context).pop();
          //    }
          //    ,
          //  )
        ],
      );
    },
  );
}

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
                width: 320,
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
                          showAlertDialog2(
                              context, 'Please select a new Value');
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

showAlertDialogGoal(BuildContext context, uid) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      var Goal = ["Select your Goal", "Body Building", "Weight Loss", "Both"]
          .map<DropdownMenuItem<String>>((String limitX) {
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
              width: 320,
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
                        showAlertDialog2(context, 'Please select a new Value');
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

showAlertDialogExp(BuildContext context, uid) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      var Experience = [
        "Select your Experience Level",
        "Less than 3 months",
        "3-6 Months",
        "6 months - 1 year",
        "1-2 years",
        "2+ years"
      ].map<DropdownMenuItem<String>>((String limitX) {
        return DropdownMenuItem(
            child: Text(
              limitX,
              style: TextStyle(color: Colors.white),
            ),
            value: limitX);
      }).toList();

      var DefaultE = "Select your Experience Level";

      return CupertinoAlertDialog(
        title: Text("Experience Level Change"),
        content: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          child: Container(
              width: 320,
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
                    items: Experience,
                    hint: Text("Select your Experience"),
                    value: DefaultE,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    dropdownColor: gr(),
                    onChanged: (String? newValue) async {
                      DefaultE = newValue!;

                      if (DefaultE != 'Select your Experience Level' &&
                          DefaultE != context.read<dataProvider>().theGender) {
                        await fire
                            .collection('Users')
                            .doc(uid)
                            .update({'Experience': DefaultE});
                        Provider.of<dataProvider>(context, listen: false)
                            .updateExp(DefaultE);
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        showAlertDialog2(context, 'Please select a new Value');
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
      showAlertDialog2(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog2(context,
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
      showAlertDialog2(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog2(context,
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
          showAlertDialog2(context,
              'Upgraded successfully please restart the app to see the new Program!');
        } else {
          showAlertDialog2(context,
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
          showAlertDialog2(context,
              'Upgraded successfully please restart the app to see the new Program!');
        } else {
          showAlertDialog2(context,
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
        showAlertDialog2(context,
            'Upgraded successfully please restart the app to see the new Program!');
      } else {
        showAlertDialog2(context,
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
      showAlertDialog2(context,
          'Upgraded successfully please restart the app to see the new Program!');
    } else {
      showAlertDialog2(context,
          'You have to reach 20 or more streak score to upgrade your program!');
    }
  } else {
    showAlertDialog2(context, 'You are already at the pro level champ!!!');
  }
}
