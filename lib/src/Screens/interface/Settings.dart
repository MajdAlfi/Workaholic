import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/dataProvider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    double heightScr = MediaQuery.of(context).size.height;
    double widthScr = MediaQuery.of(context).size.width;
    int? ageProv = context.read<dataProvider>().theAge;
    int? weightProv = context.read<dataProvider>().theWeight;
    int? heightProv = context.read<dataProvider>().theHeight;
    String? genderProv = context.read<dataProvider>().theGender;
    String? goalProv = context.read<dataProvider>().theGoal;
    String? expProv = context.read<dataProvider>().theExperience;
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
                Navigator.pushReplacementNamed(context, '/Login');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('uid');
                Provider.of<dataProvider>(context, listen: false)
                    .changeTheDay(1);
                await FirebaseAuth.instance.signOut();
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
                        child: Image.network(
                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59095529-stock-illustration-profile-icon-male-avatar.jpg",
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
                    Cont('Age', ageProv),
                    Cont('Weight', weightProv),
                    Cont('Height', heightProv),
                    Cont('Gender', genderProv),
                    Cont('Goal', goalProv),
                    Cont('Experience', expProv)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Widget Cont(String name, dynamic value) {
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
                  fontSize: 12,
                  color: Colors.white),
            ),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white),
              child: TextButton(onPressed: () {}, child: Text("Change")),
            )
          ],
        )
      ],
    ),
  );
}
