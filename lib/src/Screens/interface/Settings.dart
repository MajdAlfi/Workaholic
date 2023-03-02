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
import 'package:workout_app/src/Services/Auth/SignupSer.dart';
import 'package:workout_app/src/Services/Data%20Handling/analyze.dart';
import 'package:workout_app/src/Services/Data%20Handling/checkIfUpgradable.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialogSettings.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertGender.dart';
import 'package:workout_app/src/Services/showAlertDialog/showDialogGoal.dart';

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
    int? ageProv = context.watch<dataProvider>().theAge;
    int? weightProv = context.watch<dataProvider>().theWeight;
    int? heightProv = context.watch<dataProvider>().theHeight;
    String? genderProv = context.watch<dataProvider>().theGender;
    String? goalProv = context.watch<dataProvider>().theGoal;
    String? expProv = context.watch<dataProvider>().theExperience;
    bool? admin = context.read<dataProvider>().theAdmin;
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
                if (await checkInternetConnection() == true) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
                    Provider.of<dataProvider>(context, listen: false)
                        .deleteAll();
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/Login');
                  });
                } else {
                  showAlertDialog(
                      context, 'Please Connect to the intenet to Signout');
                }
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
              width: widthScr(context, 100),
              height: heightScr(context, 22),
              decoration: BoxDecoration(
                  color: gr(),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Stack(
                children: [
                  admin == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/admin');
                                  },
                                  icon: Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                    size: 40,
                                  ))),
                        )
                      : SizedBox(),
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
                        (context.read<dataProvider>().theName != null)
                            ? context.read<dataProvider>().theName.toString()
                            : '',
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
              height: heightScr(context, 46),
              width: widthScr(context, 85),
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
                  onPressed: () async {
                    if (await checkInternetConnection() == true) {
                      setState(() {
                        checkIfUpgradable(context, uid);
                      });
                    } else {
                      showAlertDialog(
                          context, 'Please Connect to the intenet to Upgrade');
                    }
                  },
                  child: Text(
                    'UPGRADE into more advanced exercise program',
                    textAlign: TextAlign.center,
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
              "$name: ${(value != null) ? value : ''} ",
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
                  onPressed: () async {
                    if (await checkInternetConnection() == true) {
                      if (name == 'Age' ||
                          name == 'Weight' ||
                          name == 'Height') {
                        showAlertDialogSettings(context, txt, uid);
                      } else if (name == 'Gender') {
                        showAlertDialogGender(context, uid);
                      } else if (name == 'Goal') {
                        showAlertDialogGoal(context, uid);
                      } else if (name == 'Experience') {
                        //showAlertDialogExp(context, uid);
                        showAlertDialog(context,
                            "You can't change your Experience Level as it will be considered cheating. for more info contact the developer");
                      }
                    } else {
                      showAlertDialog(context,
                          'Please Connect to the internet to update data');
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
