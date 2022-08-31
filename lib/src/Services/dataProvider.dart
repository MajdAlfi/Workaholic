import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Models/dataModel.dart';
import 'package:workout_app/src/Screens/interface/Streak.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Services/SignupSer.dart';

class dataProvider<userData> with ChangeNotifier {
  String? theUid;
  String? theName;
  String? theEmail;
  String? thePass;
  int? theAge;
  int? theWeight;
  int? theHeight;
  String? theGender;
  String? theGoal;
  String? theExperience;
  int? theStreak;
  int? theRank;
  int? theLevel;
  int? theDay;
  changeDataPro<userData>(String Name, String Email, String Pass) {
    theName = Name;
    theEmail = Email;
    thePass = Pass;
    notifyListeners();
  }

  uploadUserData<userData>(int Age, int Weight, int Height, String Gender) {
    theAge = Age;
    theWeight = Weight;
    theHeight = Height;
    theGender = Gender;

    notifyListeners();
  }

  uploadSecondData<userData>(String Goal, String Experience, int level) {
    theGoal = Goal;
    theExperience = Experience;
    theLevel = level;
    notifyListeners();
  }

  uploadLevel<userData>(int Level) {
    theLevel = Level;
    notifyListeners();
  }

  ExtraDataStreak<userData>(int Streak) {
    theStreak = Streak;

    notifyListeners();
  }

  ExtraDataRank<userData>(int Rank) {
    theRank = Rank;
    notifyListeners();
  }

  changeTheDay<userData>(int Day) {
    theDay = Day;
    notifyListeners();
  }

  changeUid<userData>(String UID) {
    theUid = UID;
    notifyListeners();
  }

  regularUse<userData>(
    String? Uid,
    String? Name,
    String? Email,
    int? Age,
    int? Weight,
    int? Height,
    String? Gender,
    String? Goal,
    String? Experience,
    int? Streak,
    int? Rank,
    int? Level,
  ) {
    theUid = Uid;
    theName = Name;
    theEmail = Email;
    theAge = Age;
    theWeight = Weight;
    theHeight = Height;
    theGender = Gender;
    theGoal = Goal;
    theExperience = Experience;
    theLevel = Level;
    theStreak = Streak;
    theRank = Rank;
    notifyListeners();
  }

  updateGender<userData>(String gender) {
    theGender = gender;
    notifyListeners();
  }

  updateAge<userData>(int Age) {
    theAge = Age;
    notifyListeners();
  }

  updateWeight<userData>(int Weight) {
    theWeight = Weight;
    notifyListeners();
  }

  updateHeight<userData>(int Height) {
    theHeight = Height;
    notifyListeners();
  }

  updateGoal<userData>(String Goal) {
    theGoal = Goal;
    notifyListeners();
  }

  updateExp<userData>(String Exp) {
    theExperience = Exp;
    notifyListeners();
  }

  deleteAll<userData>() {
    theUid = null;
    theName = null;
    theEmail = null;
    thePass = null;
    theAge = null;
    theWeight = null;
    theHeight = null;
    theGender = null;
    theGoal = null;
    theExperience = null;
    theStreak = null;
    theRank = null;
    theLevel = null;
    notifyListeners();
  }
}
