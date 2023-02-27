import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

Future<void> signupFunc(BuildContext context, TextEditingController Name,
    TextEditingController Email, TextEditingController Pass) async {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  if (Name.text == '' || Email.text == '' || Pass.text == '') {
    showAlertDialog(context, 'Please fill in the required data');
  } else if (!emailRegExp.hasMatch(Email.text)) {
    showAlertDialog(context, 'Please Enter a valid Email');
  } else {
    Provider.of<dataProvider>(context, listen: false)
        .changeDataPro(Name.text, Email.text, Pass.text);
    Navigator.pushNamed(context, '/First');
  }
}
