import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:workout_app/src/Screens/interface/Streak.dart';
import 'package:workout_app/src/Services/Func/jump.dart';
import 'package:workout_app/src/Widgets/Streak/rankTxt.dart';

import '../../Services/Others/dataProvider.dart';

Widget stackRank(BuildContext context, widthScr, int rank,
    ItemScrollController _scrollController) {
  return GestureDetector(
    onTap: () {
      if (rank != 0) {
        jump(_scrollController, rank);
      } else {
        jump(_scrollController, 100000);
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
