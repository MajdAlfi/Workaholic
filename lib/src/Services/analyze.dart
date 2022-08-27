import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

analyze(String goal, String exp, uid, String Gender, int Age, prefs) async {
  FirebaseFirestore fire = FirebaseFirestore.instance;

  if (Age >= 16 && Age <= 40) {
    if (Gender == 'Male') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1111});
          prefs.setInt('Level', 1111);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1112});
          prefs.setInt('Level', 1112);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1113});
          prefs.setInt('Level', 1113);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1114});
          prefs.setInt('Level', 1114);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1115});
          prefs.setInt('Level', 1115);
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1121});
          prefs.setInt('Level', 1121);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1122});
          prefs.setInt('Level', 1122);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1123});
          prefs.setInt('Level', 1123);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1124});
          prefs.setInt('Level', 1124);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1125});
          prefs.setInt('Level', 1125);
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1131});
          prefs.setInt('Level', 1131);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1132});
          prefs.setInt('Level', 1132);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1133});
          prefs.setInt('Level', 1133);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1134});
          prefs.setInt('Level', 1134);
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 1135});
        prefs.setInt('Level', 1135);
      }
    } else if (Gender == 'Female') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1211});
          prefs.setInt('Level', 1211);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1212});
          prefs.setInt('Level', 1212);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1213});
          prefs.setInt('Level', 1213);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1214});
          prefs.setInt('Level', 1214);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1215});
          prefs.setInt('Level', 1215);
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1221});
          prefs.setInt('Level', 1221);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1222});
          prefs.setInt('Level', 1222);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1223});
          prefs.setInt('Level', 1223);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1224});
          prefs.setInt('Level', 1224);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1225});
          prefs.setInt('Level', 1225);
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1231});
          prefs.setInt('Level', 1231);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1232});
          prefs.setInt('Level', 1232);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1233});
          prefs.setInt('Level', 1233);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1234});
          prefs.setInt('Level', 1234);
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 1235});
        prefs.setInt('Level', 1235);
      }
    }
  } else if (Age > 40 && Age <= 100) {
    if (Gender == 'Male') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2111});
          prefs.setInt('Level', 2111);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2112});
          prefs.setInt('Level', 2112);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2113});
          prefs.setInt('Level', 2113);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2114});
          prefs.setInt('Level', 2114);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2115});
          prefs.setInt('Level', 2115);
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2121});
          prefs.setInt('Level', 2121);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2122});
          prefs.setInt('Level', 2122);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2123});
          prefs.setInt('Level', 2123);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2124});
          prefs.setInt('Level', 2124);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2125});
          prefs.setInt('Level', 2125);
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2131});
          prefs.setInt('Level', 2131);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2132});
          prefs.setInt('Level', 2132);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2133});
          prefs.setInt('Level', 2133);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2134});
          prefs.setInt('Level', 2134);
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 2135});
        prefs.setInt('Level', 2135);
      }
    } else if (Gender == 'Female') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2211});
          prefs.setInt('Level', 2211);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2212});
          prefs.setInt('Level', 2212);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2213});
          prefs.setInt('Level', 2213);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2214});
          prefs.setInt('Level', 2214);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2215});
          prefs.setInt('Level', 2215);
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2221});
          prefs.setInt('Level', 2221);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2222});
          prefs.setInt('Level', 2222);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2223});
          prefs.setInt('Level', 2223);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2224});
          prefs.setInt('Level', 2224);
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2225});
          prefs.setInt('Level', 2225);
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2231});
          prefs.setInt('Level', 2231);
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2232});
          prefs.setInt('Level', 2232);
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2233});
          prefs.setInt('Level', 2233);
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2234});
          prefs.setInt('Level', 2234);
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 2235});
        prefs.setInt('Level', 2235);
      }
    }
  }
}
