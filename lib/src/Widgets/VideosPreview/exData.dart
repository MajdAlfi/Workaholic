import 'package:flutter/material.dart';
import 'package:workout_app/src/Screens/interface/desc.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/Others/height&width.dart';

Widget ExData(BuildContext context, int index, snap) {
  String thumb = snap.data!.docs[index].data()['Thumb'].toString();
  // final ref = FirebaseStorage.instance.ref().child("Thumb").child(thumb);
  // var url = ref.getDownloadURL();

  return GestureDetector(
    onTap: (() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => desc(
                  inName: snap.data!.docs[index].data()['exName'].toString(),
                  vidUrl: snap.data!.docs[index].data()['vidUrl'].toString(),
                  description: snap.data!.docs[index].data()['desc'].toString(),
                  widthGet: widthScr(context, 85),
                  heightGet: heightScr(context, 22),
                ))))),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: gr(),
      ),
      height: heightScr(context, 27),
      width: widthScr(context, 90),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 20),
                child: Text(
                  snap.data!.docs[index].data()['exName'].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(width: 1, color: Colors.white)),
                height: heightScr(context, 19),
                width: widthScr(context, 75),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(20.0),
                      child: Image.network(
                        thumb.toString(),
                        height: heightScr(context, 19),
                        width: widthScr(context, 75),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
