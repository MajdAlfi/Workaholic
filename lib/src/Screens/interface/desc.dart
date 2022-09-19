import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_app/src/Screens/Data/DataCollector1.dart';

class desc extends StatefulWidget {
  desc({
    Key? key,
    required this.inName,
    required this.vidUrl,
    required this.description,
  }) : super(key: key);

  final String inName;
  final String vidUrl;
  final String description;
  int _contSizeWidth = 350;
  int _contSizeHeight = 200;
  bool large = false;

  @override
  State<desc> createState() => _descState();
}

class _descState extends State<desc> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.vidUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: gr(),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "${widget.inName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30, color: gr()),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: double.parse(widget._contSizeHeight.toString()),
                  width: double.parse(widget._contSizeWidth.toString()),
                  decoration: BoxDecoration(
                      color: gr(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Stack(
                    children: [
                      FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Stack(
                              children: [
                                AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller)),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      colors: VideoProgressColors(
                                          playedColor: Colors.white,
                                          bufferedColor: Colors.grey),
                                    ))
                              ],
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: IconButton(
                      icon: Icon(
                        widget.large ? Icons.zoom_in_map : Icons.zoom_out_map,
                        color: gr(),
                      ),
                      color: gr(),
                      onPressed: () {
                        setState(() {
                          if (widget.large != true) {
                            widget.large = true;
                          } else {
                            widget.large = false;
                          }

                          if (widget.large == true) {
                            widget._contSizeWidth = 390;
                            widget._contSizeHeight = 220;
                          } else {
                            widget._contSizeWidth = 350;
                            widget._contSizeHeight = 200;
                          }
                        });
                      }),
                ),
                Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: gr()),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ))),
                ),
              ],
            ),
          ],
        ));
  }
}
