import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/Screens/Data/DataCollector1.dart';

class desc extends StatelessWidget {
  const desc({Key? key, required this.Name}) : super(key: key);

  final int Name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: gr(),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Name $Name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40, color: gr()),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                      color: gr(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Stack(
                    children: [
                      Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: gr()))
              ],
            ),
          ],
        ));
  }
}
