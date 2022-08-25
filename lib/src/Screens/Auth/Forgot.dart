import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';

class forgot extends StatelessWidget {
  const forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthScr = MediaQuery.of(context).size.width;
    double heightScr = MediaQuery.of(context).size.height;
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
            top: (heightScr * 0.3),
            left: (widthScr * 0.5) - 140,
            child: Container(
              width: 280,
              height: 50,
              child: TextField(
                controller: emailController,
                autofocus: false,
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
                cursorColor: gr(),
              ),
            ),
          ),
          Positioned(
              top: (heightScr * 0.3) + 80,
              left: (widthScr * 0.5) - 40,
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

Future resetPassword(
    {required String email, required BuildContext context}) async {
  final auth = FirebaseAuth.instance;
  try {
    await auth.sendPasswordResetEmail(email: email);
    showAlertDialog(context, 'Check your email please');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showAlertDialog(context, "No user found for that email.");
    } else {
      showAlertDialog(context, "Error Occured");
    }
  }
}

showAlertDialog(BuildContext context, String x) {
  // Create button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert!"),
    content: Text(x),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
