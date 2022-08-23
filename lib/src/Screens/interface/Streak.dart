import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/dataProvider.dart';

class Streak extends StatefulWidget {
  Streak({Key? key}) : super(key: key);
  late int index = 0;
  @override
  State<Streak> createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  @override
  Widget build(BuildContext context) {
    double heightScr = MediaQuery.of(context).size.height;
    double widthScr = MediaQuery.of(context).size.width;
    void intit() {
      super.initState();
      setState(() async {
        widget.index =
            await int.parse(context.read<dataProvider>().theRank.toString());
      });
    }

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
                    Align(
                        alignment: Alignment.topCenter,
                        child: ranktxt(widget.index)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          context.read<dataProvider>().theName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .orderBy('Streak', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  Text(snapshot.error.toString());
                } else if (snapshot.data == null) {
                  return Text('no Data');
                } else if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return tile(
                          snapshot.data!.docs[index].data()['Email'],
                          index + 1,
                          snapshot.data!.docs[index].data()['Name'].toString(),
                          snapshot.data!.docs[index].data()['Streak'],
                          context);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                  );
                }
                return Text('uknown Error');
              },
            )
                    // ListView.builder(
                    //     itemBuilder: (context, index) => tile(rank, "Majd"),
                    //     itemCount: 10),
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

ListTile tile(Email, int rank, String name, int streak, BuildContext context) {
  return ListTile(
      leading: Text("$rank"),
      title: NameTxt(Email, name, context, rank),
      trailing: Text('$streak🔥'));
}

Text NameTxt(Email, String name, BuildContext context, int index) {
  if (context.read<dataProvider>().theEmail == Email) {
    rankChange(context, Email, index);
    return Text(
      '$name',
      style: TextStyle(color: gr(), fontSize: 15, fontWeight: FontWeight.bold),
    );
  } else {
    return Text('$name');
  }
}

rankChange(BuildContext context, String Email, int index) async {
  Future.delayed(Duration.zero, () {
    Provider.of<dataProvider>(context, listen: false).ExtraDataRank(index);
    print(context.read<dataProvider>().theRank);
  });
}
