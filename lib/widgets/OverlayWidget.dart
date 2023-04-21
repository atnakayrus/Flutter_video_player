import "package:flutter/material.dart";
import "package:video_player/video_player.dart";
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import "package:volume_controller/volume_controller.dart";
import 'package:syncfusion_flutter_sliders/sliders.dart';
class OverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const OverlayWidget({Key? key, required this.controller}) : super(key: key);
  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
VolumeController vol=VolumeController();
var volume;double _value=0.0;
  Future<void> volume1() async {
    setState(() {
      volume= vol.getVolume();
    });

  }
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

    dynamic volume_control(){
      return SfSlider.vertical(
        min: 0.0,
        max: 100.0,
        value: _value,
        interval: 20,
        showTicks: true,
        showLabels: true,
        minorTicksPerInterval: 1,
        onChanged: (dynamic value){
          volume1();
          setState(() {
            _value = volume;
          });
        },
      );
    }
    return GestureDetector(
      onTap: (){
        widget.controller.value.isPlaying?widget.controller.pause():widget.controller.play();
      },
      child: Stack(
        children: [
          widget.controller.value.isPlaying?controls(Icons.pause):controls(Icons.play_arrow),
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
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child:Container(
              alignment: Alignment.centerLeft,
          child:volume_control() ,
          )
          ),
          // Positioned(
          //   child: Container(
          //     alignment: Alignment.center,
          //     color: Colors.white,
          //     height: 100,
          //     width: 100,
          //   ),
          // )

        ],
      ),
    );
  }
}
