import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';
import 'package:workout_app/src/Services/Auth/SignupSer.dart';
import 'package:workout_app/src/Services/Others/color.dart';
import 'package:workout_app/src/Services/showAlertDialog/showAlertDialog.dart';
import 'package:workout_app/src/Services/showAlertDialog/showLoadingDIalog.dart';

class admin extends StatefulWidget {
  @override
  State<admin> createState() => _adminState();
}

class _adminState extends State<admin> {
  final exName = TextEditingController();
  final exDesc = TextEditingController();
  late String destinationImg;
  late String destinationVid;
  var lvl = [
    "Level",
    "1111",
    "1112",
    "1113",
    "1114",
    "1115",
    "1121",
    "1122",
    "1123",
    "1124",
    "1125",
    "1131",
    "1132",
    "1133",
    "1134",
    "1135",
    "1211",
    "1212",
    "1213",
    "1214",
    "1215",
    "1221",
    "1222",
    "1223",
    "1224",
    "1225",
    "1231",
    "1232",
    "1233",
    "1234",
    "1235",
    "2111",
    "2112",
    "2113",
    "2114",
    "2115",
    "2121",
    "2122",
    "2123",
    "2124",
    "2125",
    "2131",
    "2132",
    "2133",
    "2134",
    "2135",
    "2211",
    "2212",
    "2213",
    "2214",
    "2215",
    "2221",
    "2222",
    "2223",
    "2224",
    "2225",
    "2231",
    "2232",
    "2233",
    "2234",
    "2235"
  ].map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(
        child: Text(
          limitX,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        value: limitX);
  }).toList();
  var day = [
    "Day",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ].map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(
        child: Text(
          limitX,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        value: limitX);
  }).toList();

  var DefaultL = "Level";
  var DefaultD = "Day";
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;
  File? _Vid;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickerFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile != null) {
        _photo = File(pickerFile.path);
        //   uploadImg();
      } else {
        print('No image selected.');
      }
    });
  }

  Future vidFromGallery() async {
    final pickerFile = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      if (pickerFile != null) {
        _Vid = File(pickerFile.path);
        // uploadVid();
      } else {
        print('No video selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        //   uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImg() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    destinationImg = 'Thumb/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destinationImg);
      await ref.putFile(_photo!);
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      print("Failed with error in img '${e.code}': ${e.message}");
    }
  }

  Future uploadVid() async {
    if (_Vid == null) return;
    final fileName = basename(_Vid!.path);
    destinationVid = 'Vids/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destinationVid);
      await ref.putFile(_Vid!);
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      print("Failed with error in vid '${e.code}': ${e.message}");
    }
  }

  addDataToFireStore() async {
    try {
      FirebaseFirestore fire = FirebaseFirestore.instance;
      final storageRef = FirebaseStorage.instance.ref();
      final imageUrl = await storageRef.child(destinationImg).getDownloadURL();
      final VidUrl = await storageRef.child(destinationVid).getDownloadURL();
      fire.collection('Levels').add({
        'exName': exName.text,
        'desc': exDesc.text,
        'Level': int.parse(DefaultL),
        'day': int.parse(DefaultD),
        'Thumb': imageUrl,
        'vidUrl': VidUrl
      });
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      print("Failed with error in adding '${e.code}': ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Content Upload',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: gr(),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.transparent),
                height: 600,
                width: 350,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Exercise Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gr(),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 320,
                      height: 50,
                      child: TextField(
                        controller: exName,
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Enter Exercise Name",
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: gr()),
                        cursorColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Level",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: gr(),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              "Day",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: gr(),
                                  fontSize: 20),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: gr(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down_rounded),
                                  iconEnabledColor: Colors.white,
                                  items: lvl,
                                  hint: Text(
                                    "Level",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: DefaultL,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  dropdownColor: gr(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      DefaultL = newValue!;
                                    });
                                  }),
                            )),
                        Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: gr(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                  menuMaxHeight: 200,
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down_rounded),
                                  iconEnabledColor: Colors.white,
                                  items: day,
                                  hint: Text(
                                    "Day",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: DefaultD,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  dropdownColor: gr(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      DefaultD = newValue!;
                                    });
                                  }),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Exercise Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gr(),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 320,
                      height: 150,
                      child: TextFormField(
                        controller: exDesc,
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            filled: true,
                            hintText: "Enter Exercise Description",
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: gr()),
                        cursorColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Text(
                              "Thumb",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: gr(),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 80,
                              height: 20,
                              child: Text(
                                _photo != null
                                    ? basename(_photo!.path)
                                    : 'Null',
                                style: TextStyle(color: gr(), fontSize: 8),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  "Video",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: gr(),
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                height: 20,
                                child: Text(
                                  _Vid != null ? basename(_Vid!.path) : 'Null',
                                  style: TextStyle(color: gr(), fontSize: 8),
                                ),
                              ),
                            ],
                          )
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: gr()),
                            child: Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            vidFromGallery();
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: gr()),
                            child: Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: gr()),
                      height: 50,
                      width: 350,
                      child: TextButton(
                        onPressed: () async {
                          if (_photo != null &&
                              _Vid != null &&
                              exName.text != '' &&
                              exDesc.text != '' &&
                              DefaultL != 'Level' &&
                              DefaultD != 'Day') {
                            showAlertLoading(context);
                            try {
                              await uploadImg();
                              await uploadVid();
                              await addDataToFireStore();
                              Navigator.pop(context);
                              setState(() {
                                exName.text = '';
                                exDesc.text = '';
                                destinationImg = '';
                                destinationVid = '';
                                _Vid = null;
                                _photo = null;
                                DefaultL == 'Level';
                                DefaultD == 'Day';
                              });
                              showAlertDialog(context, 'Done');
                            } on FirebaseException catch (e) {
                              print('endError ${e.message}');
                            }
                          } else {
                            showAlertDialog(context,
                                'Please fill in the required data, select Thumbnail and a video as well!');
                          }
                        },
                        child: Text(
                          'Upload',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
