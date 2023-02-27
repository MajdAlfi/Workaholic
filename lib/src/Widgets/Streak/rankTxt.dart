import 'package:flutter/material.dart';
import 'package:workout_app/src/Services/Others/color.dart';

Widget ranktxt(int rank) {
  Widget avatar;
  if (rank == 0) {
    String Rank = 'Tap Here!';
    avatar = ClipOval(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: Text(
          "$Rank",
          style:
              TextStyle(color: gr(), fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  } else {
    avatar = ClipOval(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        child: Text(
          "$rank",
          style:
              TextStyle(color: gr(), fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
  if (rank == 1) {
    return ClipOval(
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 212, 210, 44),
        radius: 70,
        child: Text(
          "$rank: Gold",
          overflow: TextOverflow.visible,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  } else if (rank == 2) {
    avatar = ClipOval(
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(99, 169, 169, 169),
        radius: 70,
        child: Text(
          "$rank: Silver",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  } else if (rank == 3) {
    avatar = ClipOval(
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 216, 119, 55),
        radius: 70,
        child: Text(
          "$rank: Bronze",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
  return avatar;
}
