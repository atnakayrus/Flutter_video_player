import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class OverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const OverlayWidget({Key? key, required this.controller}) : super(key: key);
  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {

  Widget dir(var symbol){
    return GestureDetector(
      child: Icon(symbol,color: Colors.white,size:30),
      onTap: () {
        Duration current=widget.controller.value.position;
        Duration target=(symbol==Icons.fast_rewind)?current-Duration(seconds: 10):current+Duration(seconds: 10);
        widget.controller.seekTo(target);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    int duration = widget.controller.value.duration.inMilliseconds;
    int position = widget.controller.value.position.inMilliseconds;
    double ratio=position/duration;
    dynamic controls(var ic){
      return Container(alignment:Alignment.center,child: Icon(ic,color: Colors.white,size:50),);
    }
    return GestureDetector(
      onTap: (){
        widget.controller.value.isPlaying?widget.controller.pause():widget.controller.play();
      },
      child: Stack(
        children: [
          widget.controller.value.isPlaying?
          controls(Icons.pause):
          controls(Icons.play_arrow),

          Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child:VideoProgressIndicator(widget.controller,allowScrubbing: true,)
          ),
          Positioned(
              left: (width*ratio)-10,
              bottom: 32,
              child:IgnorePointer(child: Icon(Icons.circle,color: Color.fromRGBO(255, 0, 0, 0.9),size: 20,))
          ),
          Positioned(
            left: 50,
            bottom: 5,
            child: dir(Icons.fast_forward)
          ),
          Positioned(
              left: 10,
              bottom: 5,
              child: dir(Icons.fast_rewind)
          ),

        ],
      ),
    );
  }
}
