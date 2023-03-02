import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Screens/interface/Streak.dart';
import 'package:workout_app/src/Services/Auth/SignupSer.dart';
import 'package:workout_app/src/Services/Func/checkDay.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Func/getTheDate.dart';
import 'package:workout_app/src/Services/Func/getTheName.dart';
import 'package:workout_app/src/Services/Func/nameValue.dart';
import 'package:workout_app/src/Services/Func/loadLevel.dart';
import 'package:workout_app/src/Services/Func/streakGet.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialogComplete.dart';
import 'package:workout_app/src/Widgets/VideosPreview/exData.dart';

class vids extends StatefulWidget {
  @override
  State<vids> createState() => _vidsState();
  FirebaseFirestore fireStoreH = FirebaseFirestore.instance;
}

class _vidsState extends State<vids> {
  void initState() {
    super.initState();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    setState(() {
      getTheName(uid, context);
      streakGet(widget.fireStoreH, uid.toString(), context);
      _loadCounter();
      loadLevel(uid, context);
    });
    // final docData = FirebaseFirestore.instance
    //   .collection('Levels')
    //   .get()
    //   .then((DocumentSnapshot value) { print(value.get())});
  }

  void dispose() {
    super.dispose();
    setState(() {
      _loadCounter();
      loadLevel(uid, context);

      getTheName(uid, context);
    });
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Provider.of<dataProvider>(context, listen: false)
          .changeTheDay(prefs.getInt('counter') ?? 1);
    });
  }

  Widget build(BuildContext context) {
    final fire = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final Uid = user?.uid;

    int? _counter = context.read<dataProvider>().theDay;
    print(_counter);
    //  gettheDayData(context);
    // Future<QuerySnapshot<Map<String, dynamic>>> dayName = widget.fireStoreH
    //     .collection('Levels')
    //     .where('Level', isEqualTo: context.read<dataProvider>().theLevel)
    //     .where('day', isEqualTo: _counter)
    //     .get()
    //     .then((DocumentSnapshot value) {
    //   return value.get('dayName') as Map<String, dynamic>;
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: gr(),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: fire.collection('Users').doc(Uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                CircularProgressIndicator();
              } else if (snapshot.hasError) {
                Text(snapshot.error.toString());
              } else if (snapshot.data == null) {
                return Text('no Data');
              } else if (snapshot.hasData) {
                //     streakGet(fire, Uid.toString(), context);

                return TextButton(
                  child: Text(
                      "${(context.watch<dataProvider>().theStreak != null) ? context.watch<dataProvider>().theStreak : 0}🔥",
                      style:
                          TextStyle(color: gr(), fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Streak(),
                    ));
                  },
                );
              }
              return Text('Error Occured');
            },
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Day ${(_counter != null) ? _counter : ''}|| ",
                    style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                      future: nameValue(context),
                      builder: (context, snapshot) {
                        return Text(
                          (context.read<dataProvider>().theDayName != null)
                              ? context
                                  .read<dataProvider>()
                                  .theDayName
                                  .toString()
                              : '',
                          style: TextStyle(
                              color: gr(), fontWeight: FontWeight.bold),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: gr(),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            if (await checkInternetConnection() == true) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              if (await getTheDate(prefs) == true) {
                                prefs.setBool('bool', true);
                              }
                              if (prefs.getBool('bool') == true) {
                                if (_counter != null) {
                                  if (await showAlertDialogComplete(context,
                                          'Are you sure you completed the entire workout?') ==
                                      true) {
                                    setState(() {
                                      checkDay(_counter, context);

                                      fire.collection('Users').doc(Uid).update({
                                        'Streak': (context
                                                .read<dataProvider>()
                                                .theStreak! +
                                            1)
                                      });
                                      Provider.of<dataProvider>(context,
                                              listen: false)
                                          .ExtraDataStreak(context
                                                  .read<dataProvider>()
                                                  .theStreak! +
                                              1);
                                      prefs.setBool('bool', false);
                                    });

                                    DateTime now = DateTime.now();
                                    prefs.setString(
                                        'Tmr',
                                        DateTime(now.year, now.month,
                                                now.day + 1)
                                            .toString());
                                  }
                                }
                              } else {
                                showAlertDialog(
                                    context, 'Please come back tomowrow');
                              }
                            } else {
                              showAlertDialog(context,
                                  'Please Connect the the internet to move to the next day');
                            }
                          },
                          child: Text(
                            "Done ✓",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      width: widthScr(context, 90),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: widget.fireStoreH
                            .collection('Levels')
                            .where('Level',
                                isEqualTo:
                                    context.read<dataProvider>().theLevel)
                            .where('day', isEqualTo: _counter)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            Text(snapshot.error.toString());
                          } else if (snapshot.data == null) {
                            return Text('no Data');
                          } else if (snapshot.hasData) {
                            return ListView.separated(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                //  print(readDataLevels(snapshot.data!.docs));

                                return ExData(context, index, snapshot);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                            );
                          }
                          return Text('uknown Error');
                        },
                      ))),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
