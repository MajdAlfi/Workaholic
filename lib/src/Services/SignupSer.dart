import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workout_app/src/Models/dataModel.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.uid;
Future<userData> addSignupDataDB(
    String NameX,
    String EmailX,
    int AgeX,
    int WeightX,
    int HeightX,
    int LevelX,
    String GenderX,
    String GoalX,
    String ExpX) async {
  userData userDATA = userData(
      Name: NameX,
      Email: EmailX,
      Age: AgeX,
      Weight: WeightX,
      Height: HeightX,
      Level: LevelX,
      Gender: GenderX,
      Goal: GoalX,
      Experience: ExpX);

  await fireStore.collection('Users').doc(uid).set(userDATA.toMap());
  return userDATA;
}
