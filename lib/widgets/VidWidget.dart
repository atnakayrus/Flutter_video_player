import "dart:io";

import "package:flutter/material.dart";
import "package:video_player/video_player.dart";
class VidWidget extends StatefulWidget {
  final FileSystemEntity entity;
  const VidWidget({Key? key, required this.entity}) : super(key: key);

  @override
  State<VidWidget> createState() => _VidWidgetState();
}

class _VidWidgetState extends State<VidWidget> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=VideoPlayerController.file(File(widget.entity.path))
      ..addListener(() =>setState(() {
    }))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
  return Container(
    child: _controller.value.isInitialized?
        Center(child: VideoPlayer(_controller),)
        :
    const Center(
      child: SizedBox(
        height: 200,
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
}