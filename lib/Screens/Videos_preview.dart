import 'package:flutter/material.dart';

class vids extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: gr(),
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10),
            child: Text(
              "0🔥",
              style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Day 1",
                style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
              ),
              Text(
                "Chest & Biceps",
                style: TextStyle(color: gr(), fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: 600,
                width: 350,
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) => ExData(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 288.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: gr(),
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Next Day😍",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget ExData() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      color: gr(),
    ),
    height: 220,
    width: 220,
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20),
              child: Text(
                "Name",
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
              height: 150,
              width: 270,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: new BorderRadius.circular(20.0),
                    child: Image.network(
                      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/07/running_at_sunset-1296x728-header.jpg?w=1155&h=1528",
                      height: 150,
                      width: 270,
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
  );
}

Color gr() {
  return Color.fromARGB(255, 101, 200, 112);
}
