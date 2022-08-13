import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/Screens/Data/DataCollector1.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(100)),
                color: gr()),
            child: TextButton(
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              height: heightScr - 100,
              width: widthScr - 60,
              child: Stack(
                children: [
                  Positioned(
                    top: (heightScr * 0.5) - 160,
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gr(),
                          fontSize: 40),
                    ),
                  ),
                  Positioned(
                    top: (heightScr * 0.5) - 100,
                    left: 20,
                    child: Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Enter your Name",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: gr()),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: (heightScr * 0.5) - 40,
                    left: 20,
                    child: Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: gr()),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: (heightScr * 0.5) + 20,
                    left: 20,
                    child: Container(
                      width: 280,
                      height: 50,
                      child: TextField(
                        obscureText: true,
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            fillColor: gr()),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                      top: (heightScr * 0.5) + 80,
                      left: widthScr * 0.5 + 20,
                      child: Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: gr()),
                        child: TextButton(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/First');
                          },
                        ),
                      ))
                ],
              )),
        ),
      ],
    ));
  }
}
