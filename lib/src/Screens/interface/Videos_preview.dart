import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Models/dataModel.dart';
import 'package:workout_app/src/Models/levelsModel.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Streak.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/SignupSer.dart';
import 'package:workout_app/src/Services/dataProvider.dart';
import 'package:workout_app/src/Services/test.dart';
import 'package:workout_app/src/Services/updateDay.dart';

class vids extends StatefulWidget {
  @override
  State<vids> createState() => _vidsState();
  FirebaseFirestore fireStoreH = FirebaseFirestore.instance;
}

class _vidsState extends State<vids> {
  void initState() {
    super.initState();
    _loadCounter();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    setState(() {
      getTheName(uid, context);
    });
    // final docData = FirebaseFirestore.instance
    //   .collection('Levels')
    //   .get()
    //   .then((DocumentSnapshot value) { print(value.get())});
  }

  void dispose() {
    super.dispose();
    _loadCounter();
    setState(() {
      getTheName(uid, context);
    });
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    Provider.of<dataProvider>(context, listen: false)
        .uploadLevel(await getIt());
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
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;
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
                streakGet(fire, Uid, context);

                return TextButton(
                  child: Text("${context.watch<dataProvider>().theStreak}🔥",
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
                    "Day $_counter || ",
                    style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Chest & Biceps",
                    style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
                  ),
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
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (await getTheDate(prefs) == true) {
                              prefs.setBool('bool', true);
                            }
                            if (prefs.getBool('bool') == true) {
                              if (_counter != null) {
                                if (await showAlertDialog(context,
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
                                      DateTime(now.year, now.month, now.day + 1)
                                          .toString());
                                }
                              }
                            } else {
                              showAlertDialog2(
                                  context, 'Please come back tomowrow');
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
                      width: widthScr - 30,
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

// Future<QuerySnapshot<Map<String, dynamic>>> fBuilder() async {
//   FirebaseFirestore fire = FirebaseFirestore.instance;
//   final dataX = await fire
//       .collection('Levels')
//       .doc('1')
//       .get()
//       .then((DocumentSnapshot snapshot) {
//     final dataSnap = snapshot.data() as Map<String, dynamic>;
//   });
//   return dataX;
// }

Widget ExData(BuildContext context, int index, snap) {
  String thumb = snap.data!.docs[index].data()['Thumb'].toString();
  // final ref = FirebaseStorage.instance.ref().child("Thumb").child(thumb);
  // var url = ref.getDownloadURL();

  return GestureDetector(
    onTap: (() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => desc(
                  inName: snap.data!.docs[index].data()['exName'].toString(),
                  vidUrl: snap.data!.docs[index].data()['vidUrl'].toString(),
                  description: snap.data!.docs[index].data()['desc'].toString(),
                ))))),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: gr(),
      ),
      height: 220,
      width: 220,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20),
                child: Text(
                  snap.data!.docs[index].data()['exName'].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(width: 1, color: Colors.white)),
                height: 150,
                width: 270,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(20.0),
                      child: Image.network(
                        thumb.toString(),
                        height: 150,
                        width: 270,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

// Future gettheDayData(BuildContext context) async {
//   FirebaseFirestore fireStoreH = FirebaseFirestore.instance;
//   User? user;
//   Future dataDay = fireStoreH
//       .collection('Users')
//       .doc(user?.uid)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     int exists = 1;
//     if (documentSnapshot.get('day').exists == false) {
//       print('Document does not exist on the database');
//     } else {
//       exists = documentSnapshot.get('day');
//     }
//     return exists;
//   });
//   int count = await dataDay;
//   Provider.of<dataProvider>(context, listen: false)
//       .changeTheDay(int.parse(count.toString()));
// }
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

getTheName(uid, BuildContext context) async {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  userData dataU;
  final user = fire.collection('Users').doc(uid);
  Future USERData = user.get().then((DocumentSnapshot event) {
    dataU = userData.fromMap(event.data() as Map<String, dynamic>);

    return dataU;
  });
  userData dataX = await USERData;
  Provider.of<dataProvider>(context, listen: false).regularUse(
      uid,
      dataX.Name,
      dataX.Email,
      dataX.Age,
      dataX.Weight,
      dataX.Height,
      dataX.Gender,
      dataX.Goal,
      dataX.Experience,
      dataX.Streak,
      dataX.Rank,
      dataX.Level);
}

streakGet(fire, Uid, context) async {
  Future streakData = fire
      .collection('Users')
      .doc(Uid)
      .get()
      .then((DocumentSnapshot value) async {
    if (value.exists) {
      return value.get('Streak');
    }
  });
  int streakCount = await streakData;
  Provider.of<dataProvider>(context, listen: false)
      .ExtraDataStreak(streakCount);
}

showAlertDialog(BuildContext context, String x) async {
  bool result = false;
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Alert"),
        content: Text(x),
        actions: [
          CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              }),
          CupertinoDialogAction(
            child: Text("NO"),
            onPressed: () {
              Navigator.of(context).pop();
              result = false;
            },
          )
        ],
      );
    },
  );
  return result;
}

showAlertDialog2(BuildContext context, String x) async {
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Alert"),
        content: Text(x),
        actions: [
          CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}

bool getTheDate(prefs) {
  DateTime now = DateTime.now();
  bool result = false;
  if (DateTime.parse(prefs.getString('Tmr')!).compareTo(DateTime.now()) < 0) {
    result = true;
    return result;
  } else {
    print(false);
  }
  return result;
}

Color ButtonColor(prefs) {
  if (prefs.getBool('bool') == true) {
    return gr();
  } else {
    return Colors.grey;
  }
}

getIt() async {
  final prefs = await SharedPreferences.getInstance();

  int x = prefs.getInt('Level')!;

  return x;
}
