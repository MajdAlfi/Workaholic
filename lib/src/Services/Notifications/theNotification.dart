import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Notifications/notiicationInIt.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

theNotification(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final sharedDate = prefs.get('notDate');
  final date = DateTime.parse(sharedDate.toString());

  Provider.of<dataProvider>(context, listen: false).setNotifcationDate(date);
  int streak = int.parse(context.read<dataProvider>().theStreak.toString());
  DateTime notDate = (context.read<dataProvider>().NotDate != null)
      ? context.read<dataProvider>().NotDate
      : Provider.of<dataProvider>(context, listen: false)
          .setNotifcationDate(DateTime.now().add(Duration(seconds: 10)));
  notiicationInIt.showNotification(
      scheduledDate: context.read<dataProvider>().NotDate!,
      title: 'Come back we miss you!!',
      body: 'you have reached $streak Streak lets increase that');
}
