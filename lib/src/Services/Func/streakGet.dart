import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

streakGet(FirebaseFirestore fire, String Uid, BuildContext context) async {
  Future streakData =
      fire.collection('Users').doc(Uid).get().then((DocumentSnapshot value) {
    if (value.exists) {
      return value.get('Streak');
    }
  });
  if (streakData != null) {
    int streakCount = await streakData;
    Provider.of<dataProvider>(context, listen: false)
        .ExtraDataStreak(streakCount);
  }
}
