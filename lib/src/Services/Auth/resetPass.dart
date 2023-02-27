import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

Future resetPassword(
    {required String email, required BuildContext context}) async {
  final auth = FirebaseAuth.instance;
  try {
    await auth.sendPasswordResetEmail(email: email);
    showAlertDialog(context, 'Check your email please');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showAlertDialog(context, "No user found for that email.");
    } else {
      showAlertDialog(context, "Error Occured");
    }
  }
}
