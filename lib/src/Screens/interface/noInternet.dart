import 'package:flutter/material.dart';
import 'package:workout_app/src/Services/Func/checkInternetConnection.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

class noInternet extends StatefulWidget {
  const noInternet({Key? key}) : super(key: key);

  @override
  State<noInternet> createState() => _noInternetState();
}

class _noInternetState extends State<noInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_connected_no_internet_4,
              size: 200,
              color: gr(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please Connect to the internet To access this page :)',
              style: TextStyle(
                  color: gr(), fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: gr(),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    onPressed: () async {
                      (await checkInternetConnection() == true)
                          ? Navigator.pushReplacementNamed(context, '/vids')
                          : showAlertDialog(context,
                              'Please connect to an internet to access the app');
                    },
                    child: Text(
                      'Reload',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )))
          ],
        ),
      ),
    );
  }
}
