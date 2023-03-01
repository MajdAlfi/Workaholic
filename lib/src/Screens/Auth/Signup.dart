import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/Auth/signUpFunc.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextEditingController();
    final emailField = TextEditingController();
    final passField = TextEditingController();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0, right: 30),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                height: heightScr(context, 80),
                width: widthScr(context, 90),
                child: Stack(
                  children: [
                    Positioned(
                        top: (heightScr(context, 1)) - 100,
                        left: -20,
                        child: Image.asset(
                          'assets/images/pic.png',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      top: (heightScr(context, 50)) - 160,
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gr(),
                            fontSize: 40),
                      ),
                    ),
                    Positioned(
                      top: (heightScr(context, 50)) - 100,
                      left: 20,
                      child: Container(
                        width: 280,
                        height: 50,
                        child: TextField(
                          controller: nameField,
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
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
                      top: (heightScr(context, 50)) - 40,
                      left: 20,
                      child: Container(
                        width: 280,
                        height: 50,
                        child: TextField(
                          controller: emailField,
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
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
                      top: (heightScr(context, 50)) + 20,
                      left: 20,
                      child: Container(
                        width: 280,
                        height: 50,
                        child: TextField(
                          controller: passField,
                          obscureText: true,
                          autofocus: false,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
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
                        top: (heightScr(context, 50)) + 80,
                        left: widthScr(context, 50) + 20,
                        child: Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: gr()),
                          child: TextButton(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                            onPressed: () async {
                              if (await checkInternetConnection() == true) {
                                signupFunc(
                                    context, nameField, emailField, passField);
                              } else {
                                showAlertDialog(context,
                                    'Please Connect to the internet to Signup');
                              }
                            },
                          ),
                        ))
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
