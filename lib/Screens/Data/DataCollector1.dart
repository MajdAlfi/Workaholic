import 'package:flutter/material.dart';
import 'package:workout_app/Screens/Auth/Login.dart';
import 'package:workout_app/Screens/Auth/Signup.dart';
import 'package:workout_app/Screens/Settings.dart';
import 'package:workout_app/Screens/Videos_preview.dart';
import 'package:workout_app/Screens/desc.dart';

import 'DataCollector2.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var Gender = ["Select your Gender", "Male", "Female"]
      .map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(
        child: Text(
          limitX,
          style: TextStyle(color: Colors.white),
        ),
        value: limitX);
  }).toList();
  var DefaultG = "Select your Gender";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: gr(),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gr(), fontSize: 30),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Age",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gr(), fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      hintText: "Enter your Age",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: gr()),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Weight",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gr(), fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      hintText: "Enter your Weight",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: gr()),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Height",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gr(), fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      filled: true,
                      hintText: "Enter your Height",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: gr()),
                  cursorColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Gender",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: gr(), fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                      color: gr(),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        iconEnabledColor: Colors.white,
                        items: Gender,
                        hint: Text("Select your Gender"),
                        value: DefaultG,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        dropdownColor: gr(),
                        onChanged: (String? newValue) {
                          setState(() {
                            DefaultG = newValue!;
                          });
                        }),
                  )),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 105.0),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: gr()),
                  child: TextButton(
                      onPressed: () => Push(context),
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void Push(BuildContext context) {
  Navigator.pushNamed(context, '/second');
}

Color gr() {
  return Color.fromARGB(255, 52, 165, 118);
}
