import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

rankChange(BuildContext context, int index) async {
  Provider.of<dataProvider>(context, listen: false).ExtraDataRank(index);
  print(context.read<dataProvider>().theRank);
}
