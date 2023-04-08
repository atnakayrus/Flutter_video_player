import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class OverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const OverlayWidget({Key? key, required this.controller}) : super(key: key);
  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.controller.value.isPlaying?widget.controller.pause():widget.controller.play();
      },
      child: Stack(
        children: [
          widget.controller.value.isPlaying?
                Container(alignment:Alignment.center,child: Icon(Icons.pause,color: Colors.white,size:30),):
          Container(alignment:Alignment.center,child: Icon(Icons.play_arrow,color: Colors.white,size: 30,),),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(widget.controller, allowScrubbing: true))
        ],
      ),
    );
  }
}
