import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/Screens/Data/DataCollector1.dart';
import 'package:workout_app/main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 100,
          left: widthScr * 0.7,
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
                Navigator.pushReplacementNamed(context, '/Signup');
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              height: heightScr - 100,
              width: widthScr - 60,
              decoration: BoxDecoration(
                  color: gr(),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(500),
                  )),
              child: Stack(
                children: [
                  Positioned(
                    top: (heightScr * 0.5) - 100,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40),
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
                        style: TextStyle(color: gr()),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Enter your Email",
                            hintStyle: TextStyle(
                              color: gr(),
                            ),
                            fillColor: Colors.white),
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
                        style: TextStyle(color: gr()),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: gr(),
                            ),
                            fillColor: Colors.white),
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
                            color: Colors.white),
                        child: TextButton(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: gr(),
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/vids');
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
