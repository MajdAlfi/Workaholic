import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/src/Screens/interface/Videos_preview.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';

showAlertDialogExp(BuildContext context, uid) {
  FirebaseFirestore fire = FirebaseFirestore.instance;
  showCupertinoDialog(
    context: context,
    builder: (context) {
      var Experience = [
        "Select your Experience Level",
        "Less than 3 months",
        "3-6 Months",
        "6 months - 1 year",
        "1-2 years",
        "2+ years"
      ].map<DropdownMenuItem<String>>((String limitX) {
        return DropdownMenuItem(
            child: Text(
              limitX,
              style: TextStyle(color: Colors.white),
            ),
            value: limitX);
      }).toList();

      var DefaultE = "Select your Experience Level";

      return CupertinoAlertDialog(
        title: Text("Experience Level Change"),
        content: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          child: Container(
              width: widthScr(context, 80),
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
                    items: Experience,
                    hint: Text("Select your Experience"),
                    value: DefaultE,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    dropdownColor: gr(),
                    onChanged: (String? newValue) async {
                      DefaultE = newValue!;

                      if (DefaultE != 'Select your Experience Level' &&
                          DefaultE != context.read<dataProvider>().theGender) {
                        await fire
                            .collection('Users')
                            .doc(uid)
                            .update({'Experience': DefaultE});
                        Provider.of<dataProvider>(context, listen: false)
                            .updateExp(DefaultE);
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        showAlertDialog(context, 'Please select a new Value');
                      }
                    }),
              )),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
