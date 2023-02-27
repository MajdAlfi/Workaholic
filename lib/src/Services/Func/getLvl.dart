import 'package:shared_preferences/shared_preferences.dart';

getLvl() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getInt('Level') != null) {
    int x = prefs.getInt('Level')!;
    return x;
  } else {
    print('Error occured');
  }
}
