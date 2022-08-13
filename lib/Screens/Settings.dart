import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/Screens/Data/DataCollector1.dart';
import 'package:workout_app/Screens/Videos_preview.dart';
import 'package:workout_app/Screens/desc.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Text(
                    "SignOut",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ))
        ],
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
              child: Stack(
                children: [
                  Positioned(
                    left: (widthScr * 0.5) - 70,
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          "https://st2.depositphotos.com/1006318/5909/v/950/depositphotos_59095529-stock-illustration-profile-icon-male-avatar.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      radius: 70,
                    ),
                  ),
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
          SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            width: 320,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: gr()),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => Cont("Age", 20)),
                itemCount: 6),
          ),
        ],
      ),
    );
  }
}

Widget Cont(String name, int value) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "$name: $value",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white),
              child: TextButton(onPressed: () {}, child: Text("Change")),
            )
          ],
        )
      ],
    ),
  );
}
