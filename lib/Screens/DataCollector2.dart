import 'package:flutter/material.dart';

class DataCollector2 extends StatefulWidget {
  @override
  State<DataCollector2> createState() => _DataCollector2State();
}

class _DataCollector2State extends State<DataCollector2> {
  var Goal = [
    "Select your Goal",
    "Body Building",
    "Weight Loss",
    "Power Lifting",
    "Cross Fit"
  ].map<DropdownMenuItem<String>>((String limitX) {
    return DropdownMenuItem(
        child: Text(
          limitX,
          style: TextStyle(color: Colors.white),
        ),
        value: limitX);
  }).toList();

  var DefaultG = "Select your Goal";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 101, 200, 112),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Goal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 101, 200, 112),
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 101, 200, 112),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        iconEnabledColor: Colors.white,
                        items: Goal,
                        hint: Text("Select your Goal"),
                        value: DefaultG,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        dropdownColor: Color.fromARGB(255, 101, 200, 112),
                        onChanged: (String? newValue) {
                          setState(() {
                            DefaultG = newValue!;
                          });
                        }),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: Text(
                  "Experience",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 101, 200, 112),
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 320,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 101, 200, 112),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        iconEnabledColor: Colors.white,
                        items: Experience,
                        hint: Text("Select your Experience Level"),
                        value: DefaultE,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        dropdownColor: Color.fromARGB(255, 101, 200, 112),
                        onChanged: (String? newValue) {
                          setState(() {
                            DefaultE = newValue!;
                          });
                        }),
                  )),
              SizedBox(
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 101, 200, 112)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
