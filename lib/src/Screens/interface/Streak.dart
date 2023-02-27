import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/Auth/SignupSer.dart';
import 'package:workout_app/src/Services/Data%20Handling/getValueStreak.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Func/jump.dart';
import 'package:workout_app/src/Widgets/Streak/listTile.dart';
import 'package:workout_app/src/Widgets/Streak/stackRank.dart';

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
                width: widthScr,
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
                          int.parse(
                              context.watch<dataProvider>().theRank.toString()),
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
