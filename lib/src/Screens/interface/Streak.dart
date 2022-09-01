import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/SignupSer.dart';
import 'package:workout_app/src/Services/dataProvider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Streak extends StatefulWidget {
  Streak({Key? key}) : super(key: key);
  final _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionListener =
      ItemPositionsListener.create();
  @override
  State<Streak> createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  @override
  Widget build(BuildContext context) {
    final fire = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final Uid = user?.uid;
    double heightScr = MediaQuery.of(context).size.height;
    double widthScr = MediaQuery.of(context).size.width;
    // rankChange(context, context.read<dataProvider>().theEmail.toString(),
    //     widget.index);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: gr(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
        ),
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
                child: StreamBuilder(
                  stream: fire.collection('Users').doc(Uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return Text('no Data');
                    } else if (snapshot.hasData) {
                      return stackRank(
                          context,
                          widthScr,
                          context.read<dataProvider>().theRank as int,
                          widget._scrollController);
                    }
                    return Text('Uknown Error');
                  },
                )

                //Provider.of<dataProvider>(context, listen: false).ExtraDataRank(count);,
                ),
            Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .orderBy('Streak', descending: true)

                  //     .startAt(
                  //         [context.read<dataProvider>().theStreak! + 50]).endAt([
                  //   context.read<dataProvider>().theStreak! - 50
                  // ])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  Text(snapshot.error.toString());
                } else if (snapshot.data == null) {
                  return Text('no Data');
                } else if (snapshot.hasData) {
                  return ScrollablePositionedList.builder(
                    itemScrollController: widget._scrollController,
                    itemCount: snapshot.data!.docs.length,
                    itemPositionsListener: widget.itemPositionListener,
                    itemBuilder: (context, index) {
                      if (context.read<dataProvider>().theEmail ==
                          snapshot.data!.docs[index].data()['Email']) {
                        fire
                            .collection('Users')
                            .doc(Uid)
                            .update({'Rank': index + 1});

                        getValue(context, index + 1);

                        //         print(nums.skip(index - 3).take(index + 4));
                      }
                      return tile(
                          snapshot.data!.docs[index].data()['Email'],
                          index + 1,
                          snapshot.data!.docs[index].data()['Name'].toString(),
                          snapshot.data!.docs[index].data()['Streak'],
                          context);
                    },
                    // separatorBuilder: (context, index) => SizedBox(
                    //   height: 10,
                    //   ),
                  );
                }
                return Text('uknown Error');
              },
            )
                    // ListView.builder(
                    //     itemBuilder: (context, index) => tile(rank, "Majd"),
                    //     itemCount: 10),
                    )),
          ],
        ));
  }
}

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

ListTile tile(Email, int rank, String name, int streak, BuildContext context) {
  return ListTile(
      leading: Text("$rank"),
      title: NameTxt(Email, name, context, rank),
      trailing: Text('$streak🔥'));
}

Text NameTxt(Email, String name, BuildContext context, int index) {
  if (context.read<dataProvider>().theEmail == Email) {
    return Text(
      '$name',
      style: TextStyle(color: gr(), fontSize: 15, fontWeight: FontWeight.bold),
    );
  } else {
    return Text('$name');
  }
}

Future rankChange(BuildContext context, int index) async {
  Provider.of<dataProvider>(context, listen: false).ExtraDataRank(index);
  print(context.read<dataProvider>().theRank);
}

getValue(context, int index) async {
  Future.delayed(Duration.zero, () {
    Provider.of<dataProvider>(context, listen: false).ExtraDataRank(index);
  });
}

Widget stackRank(BuildContext context, widthScr, int rank,
    ItemScrollController _scrollController) {
  return GestureDetector(
    onTap: () {
      if (rank != 0) {
        jump(_scrollController, rank);
      } else {
        jump(_scrollController, 10000);
      }
    },
    child: Stack(
      children: [
        Positioned(
          left: (widthScr * 0.1) + 10,
          top: 30,
          child: Text(
            "Rank:",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        ),
        Align(alignment: Alignment.topCenter, child: ranktxt(rank)),
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
    ),
  );
}

Future jump(ItemScrollController _scrollController, int index) async {
  _scrollController.jumpTo(index: index, alignment: 0.5);
}
