import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

ListTile tile(Email, int rank, String name, int streak, BuildContext context) {
  return ListTile(
      leading: Text("$rank"),
      title: NameTxt(Email, name, context, rank),
      trailing: Text('$streak🔥'));
}

Text NameTxt(Email, String name, BuildContext context, int index) {
  if (context.read<dataProvider>().theEmail == Email) {
    return Text(
      '$name',
      style: TextStyle(color: gr(), fontSize: 15, fontWeight: FontWeight.bold),
    );
  } else {
    return Text('$name');
  }
}
