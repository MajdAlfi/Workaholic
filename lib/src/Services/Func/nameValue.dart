import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

nameValue(BuildContext context) async {
  String theDay = context.read<dataProvider>().theDay.toString();
  Future snap = FirebaseFirestore.instance
      .collection('Days')
      .doc(theDay)
      .get()
      .then((DocumentSnapshot value) {
    if (value.exists) return value.get('dayName');
  });
  String dayName = await snap;

  Provider.of<dataProvider>(context, listen: false).changeDayName(dayName);
}
