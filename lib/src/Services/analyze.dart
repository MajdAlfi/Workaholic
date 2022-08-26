import 'package:cloud_firestore/cloud_firestore.dart';

analyze(String goal, String exp, uid, String Gender, int Age) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  if (Age >= 16 && Age <= 40) {
    if (Gender == 'Male') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1111});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1112});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1113});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1114});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1115});
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1121});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1122});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1123});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1124});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1125});
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1131});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1132});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1133});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1134});
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 1135});
      }
    } else if (Gender == 'Female') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1211});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1212});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1213});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1214});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1215});
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1221});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1222});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1223});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1224});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 1225});
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 1231});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 1232});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 1233});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 1234});
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 1235});
      }
    }
  } else if (Age > 40 && Age <= 100) {
    if (Gender == 'Male') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2111});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2112});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2113});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2114});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2115});
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2121});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2122});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2123});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2124});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2125});
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2131});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2132});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2133});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2134});
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 2135});
      }
    } else if (Gender == 'Female') {
      if (goal == 'Body Building') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2211});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2212});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2213});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2214});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2215});
        }
      } else if (goal == 'Weight Loss') {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2221});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2222});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2223});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2224});
        } else if (exp == "2+ years") {
          fire.collection('Users').doc(uid).update({'Level': 2225});
        }
      } else {
        if (exp == "Less than 3 months") {
          fire.collection('Users').doc(uid).update({'Level': 2231});
        } else if (exp == "3-6 Months") {
          fire.collection('Users').doc(uid).update({'Level': 2232});
        } else if (exp == "6 months - 1 year") {
          fire.collection('Users').doc(uid).update({'Level': 2233});
        } else if (exp == "1-2 years") {
          fire.collection('Users').doc(uid).update({'Level': 2234});
        } else if (exp == "2+ years")
          fire.collection('Users').doc(uid).update({'Level': 2235});
      }
    }
  }
}
