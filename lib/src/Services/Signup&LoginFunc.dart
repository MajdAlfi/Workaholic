import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/SignupSer.dart';
import 'package:workout_app/src/Services/analyze.dart';

Future<User?> signupAuth(
    BuildContext context,
    String Name,
    String Email,
    String Pass,
    int Age,
    int Weight,
    int Height,
    int Level,
    String Gender,
    String Goal,
    String Exp) async {
  final auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(email: Email, password: Pass);

    await addSignupDataDB(
        Name, Email, Age, Weight, Height, Level, 0, 0, Gender, Goal, Exp);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', userCredential.user!.uid);
    prefs.setString('Tmr', DateTime.now().toString());
    prefs.setBool('bool', true);
    await analyze(Goal, Exp, uid, Gender, Age);
    user = userCredential.user;
    await user?.updateDisplayName(Name);
    await user?.reload();
    user = auth.currentUser;
    delayPushU(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showAlertDialog(context, "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      showAlertDialog(context, 'The account already exists for that email.');
    }
  } catch (e) {
    showAlertDialog(context, e.toString());
  }
  return user;
}

Future<void> loginFunc(BuildContext context, TextEditingController email,
    TextEditingController Pass) async {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (email.text == '' || Pass.text == '') {
    showAlertDialog(context, "Please Enter fill in the fields");
  } else if (!emailRegExp.hasMatch(email.text)) {
    showAlertDialog(context, "Enter a valid Email");
  } else {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email.text, password: Pass.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', userCredential.user!.uid);
      prefs.setString('Tmr', DateTime.now().toString());
      prefs.setBool('bool', true);
      delayPushU(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showAlertDialog(context, "Wrong password provided.");
      }
    }
  }
}

Future delayPushU(BuildContext context) async {
  await new Future.delayed(new Duration(milliseconds: 500), () {
    Navigator.pushReplacementNamed(context, '/vids');
  });
}

showAlertDialog(BuildContext context, String x) {
  showCupertinoDialog(
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
