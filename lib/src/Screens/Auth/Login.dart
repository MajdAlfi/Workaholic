import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/main.dart';
import 'package:workout_app/src/Services/Auth/Signup&LoginFunc.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';
import 'package:workout_app/src/Services/showAlertDialog/showLoadingDIalog.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          body: Stack(
        children: [
          Positioned(
            top: 100,
            left: widthScr(context, 70),
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
                height: heightScr(context, 85),
                width: widthScr(context, 90),
                decoration: BoxDecoration(
                    color: gr(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(500),
                    )),
                child: Stack(
                  children: [
                    Positioned(
                        top: (heightScr(context, 20)) - 100,
                        left: -20,
                        child: Image.asset(
                          'assets/images/logo2png.png',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      top: (heightScr(context, 50)) - 100,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40),
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
                          style: TextStyle(color: gr()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              hintText: "Enter your Email",
                              hintStyle: TextStyle(
                                color: gr(),
                              ),
                              fillColor: Colors.white),
                          cursorColor: gr(),
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
                          controller: passwordField,
                          obscureText: true,
                          style: TextStyle(color: gr()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: gr(),
                              ),
                              fillColor: Colors.white),
                          cursorColor: gr(),
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
                              color: Colors.white),
                          child: TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: gr(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                            onPressed: () async {
                              if (await checkInternetConnection() == true) {
                                showAlertLoading(context);
                                await loginFunc(
                                        context, emailField, passwordField)
                                    .then((_) => Navigator.pop(context));
                              } else {
                                showAlertDialog(context,
                                    'Please Connect to the internet to login ');
                              }
                            },
                          ),
                        )),
                    Positioned(
                      top: (heightScr(context, 50)) + 110,
                      left: widthScr(context, 50) - 170,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Forgot');
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
