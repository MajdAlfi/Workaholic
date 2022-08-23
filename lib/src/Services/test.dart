import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/src/Models/levelsModel.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
Future<DocumentSnapshot<Map<String, dynamic>>> readDataLevels(snap) async {
  final lvlData = await snap;
  return lvlData;
}
