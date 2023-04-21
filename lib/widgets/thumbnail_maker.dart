import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class thumbnail_maker extends StatefulWidget {
  final FileSystemEntity entity;
  const thumbnail_maker({Key? key, required this.entity}) : super(key: key);

  @override
  State<thumbnail_maker> createState() => _thumbnail_makerState();
}

class _thumbnail_makerState extends State<thumbnail_maker> {
  late VideoPlayerController _controller;
  late FileSystemEntity entity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    entity=widget.entity;
    _controller=VideoPlayerController.file(File(entity.path))
      ..initialize().then((_) {
        setState(() {
        });
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Container(
      width: 50.0,
      height: 50.0,
      child: VideoPlayer(_controller),
    )
        : CircularProgressIndicator();
  }
}
