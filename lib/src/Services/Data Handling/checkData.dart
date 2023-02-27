import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

checkData(
    BuildContext context, int Age, int Weight, int Height, String Gender) {
  if ((Age >= 16 && Age < 100) &&
      (Weight > 0 && Weight < 300) &&
      (Height > 0 && Height < 250) &&
      (Gender == 'Male' || Gender == 'Female')) {
    Provider.of<dataProvider>(context, listen: false)
        .uploadUserData(Age, Weight, Height, Gender);
    Navigator.pushNamed(context, '/Second');
  } else {
    showAlertDialog(context, 'Please Enter a reasonable data');
  }
}
