import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_app/src/Services/Func/getLvl.dart';
import 'package:workout_app/src/Services/Func/setLvl.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

loadLevel(uid, context) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getInt('Level') != null) {
    int digit = await getLvl();
    Provider.of<dataProvider>(context, listen: false).uploadLevel(digit);
    print('digit1:$digit');
  } else {
    await setLvl(context, uid);
    int digit = await getLvl();
    Provider.of<dataProvider>(context, listen: false).uploadLevel(digit);
    print('digit2:$digit');
  }
}
