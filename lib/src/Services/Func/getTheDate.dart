bool getTheDate(prefs) {
  DateTime now = DateTime.now();
  bool result = false;
  if (DateTime.parse(prefs.getString('Tmr')!).compareTo(DateTime.now()) < 0) {
    result = true;
    return result;
  } else {
    print(false);
  }
  return result;
}
