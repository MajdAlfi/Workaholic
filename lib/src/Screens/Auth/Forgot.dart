import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Services/Auth/resetPass.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';

import '../../Services/showAlertDialog/showAlertDialog.dart';

class forgot extends StatelessWidget {
  const forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: gr(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: (heightScr(context, 10)),
            left: (widthScr(context, 50)) - 160,
            child: Text(
              'Forgotten Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: gr(), fontSize: 30),
            ),
          ),
          Positioned(
            top: (heightScr(context, 23)),
            left: (widthScr(context, 42)) - 135,
            child: Container(
              width: widthScr(context, 85),
              height: heightScr(context, 05),
              child: TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
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
              top: (heightScr(context, 30)) + 30,
              left: (widthScr(context, 50)) - 40,
              child: Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: gr()),
                child: TextButton(
                  child: Text(
                    "Reset",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                  onPressed: () async {
                    RegExp emailRegExp = RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                    if (emailController.text == '') {
                      showAlertDialog(
                          context, "Please Enter fill in the fields");
                    } else if (!emailRegExp.hasMatch(emailController.text)) {
                      showAlertDialog(context, "Enter a valid Email");
                    } else {
                      resetPassword(
                          email: emailController.text, context: context);
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}
