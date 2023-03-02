import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Models/dataModel.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

getTheName(uid, BuildContext context) async {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  userData dataU;
  final user = fire.collection('Users').doc(uid);
  Future USERData = user.get().then((DocumentSnapshot event) {
    dataU = userData.fromMap(event.data() as Map<String, dynamic>);

    return dataU;
  });
  if (USERData != null) {
    userData dataX = await USERData;
    await Provider.of<dataProvider>(context, listen: false).regularUse(
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
        dataX.Level,
        dataX.admin);
  }
}
