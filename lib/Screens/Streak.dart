import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/Screens/Data/DataCollector1.dart';
import 'package:workout_app/Screens/Videos_preview.dart';
import 'package:workout_app/Screens/desc.dart';

class Streak extends StatelessWidget {
  Streak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rank = 4;
    double heightScr = MediaQuery.of(context).size.height;
    double widthScr = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: gr(),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            )),
        body: Column(
          children: [
            Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                    color: gr(),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Stack(
                  children: [
                    Positioned(
                      left: (widthScr * 0.1) + 10,
                      top: 30,
                      child: Text(
                        "Rank:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                        left: (widthScr * 0.5) - 70, child: ranktxt(rank)),
                    Positioned(
                      left: (widthScr * 0.5) - 35,
                      top: 150,
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemBuilder: (context, index) => tile(rank, "Majd"),
                  itemCount: 10),
            ))
          ],
        ));
  }
}

Widget ranktxt(int rank) {
  Widget avatar = ClipOval(
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

ListTile tile(
  int rank,
  String name,
) {
  return ListTile(
    leading: Text("$rank"),
    title: Text("$name"),
    trailing: ClipOval(
        child: Image.network(
      "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59095529-stock-illustration-profile-icon-male-avatar.jpg",
      fit: BoxFit.fill,
    )),
  );
}
