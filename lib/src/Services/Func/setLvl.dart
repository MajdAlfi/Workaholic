import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

setLvl(BuildContext context, uid) async {
  final prefs = await SharedPreferences.getInstance();
  final Num = FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot value) {
    return value.get('Level');
  });
  int lvlInt = await Num;
  if (lvlInt != null) {
    prefs.setInt('Level', lvlInt);
    print('ok:${lvlInt}');
  } else {
    print('its null!!!!');
  }
}
