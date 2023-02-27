import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlertDialogComplete(BuildContext context, String x) async {
  bool result = false;
  await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Alert"),
        content: Text(x),
        actions: [
          CupertinoDialogAction(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              }),
          CupertinoDialogAction(
            child: Text("NO"),
            onPressed: () {
              Navigator.of(context).pop();
              result = false;
            },
          )
        ],
      );
    },
  );
  return result;
}
