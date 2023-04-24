import "package:flutter/material.dart";
import "package:video_player/video_player.dart";
import "package:volume_controller/volume_controller.dart";
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/services.dart';


class OverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const OverlayWidget({Key? key, required this.controller}) : super(key: key);
  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
VolumeController vol=VolumeController();
var volume;double _value=0.0;    var rotate=true;

int maxVol=0, currentVol=0;

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
  Future<void> setter()async {
    _value=await vol.getVolume();
  }


@override
  Widget build(BuildContext context) {
    setter();
    bool ismute=_value==0?true:false;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    int duration = widget.controller.value.duration.inMilliseconds;
    int position = widget.controller.value.position.inMilliseconds;
    double ratio=position/duration;
    dynamic controls(var ic){
      return Container(alignment:Alignment.center,child: Icon(ic,color: Colors.white,size:50),);
    }

    dynamic volume_control(){
      return Container(
        height: 200,
        child: SfSlider.vertical(
          activeColor: Colors.white,
          inactiveColor: Colors.black,
          min: 0.0,
          max: 1,
          value: _value,
          interval: 0.1,
          showTicks: true,
          showLabels: false,
          minorTicksPerInterval: 1,
          onChanged: (dynamic value) async {
            setState(() {
              _value = value;
              vol.setVolume(value);
            });
          },
        ),
      );
    }
    dynamic mute_button(){
      return widget.controller.value.isInitialized?GestureDetector(
        onTap: (){
          setState(() {
            vol.showSystemUI=false;
            if(ismute==false){
              volume=_value;
            }
            else{
              _value=volume;
            }
            ismute=!ismute;
            if(ismute==false){
              vol.setVolume(volume);
            }
            else{
              _value=0;
              vol.muteVolume();
            }
          });

        },
        child: ismute?Icon(Icons.volume_mute,size: 30,color: Colors.white,):Icon(Icons.volume_up,size: 30,color: Colors.white),
      ):Text("");
    }
    return GestureDetector(
      onTap: (){
        widget.controller.value.isPlaying?widget.controller.pause():(widget.controller.value.position==widget.controller.value.duration)?widget.controller.seekTo(Duration(seconds: 0,minutes: 0,hours: 0)):widget.controller.play();
      },
      child: Stack(
        children: [
          widget.controller.value.isPlaying?controls(Icons.pause):(widget.controller.value.position==widget.controller.value.duration)?controls(Icons.replay):controls(Icons.play_arrow),
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
              right: 10,
              bottom: 5,
              child:rotate_screen()
          ),
          Positioned(
              right: 50,
              bottom: 5,
              child:mute_button()
          ),
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child:Align(
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

  rotate_screen() {
    return GestureDetector(
      onTap: (){
        setState(() {
          rotate=!rotate;
        });
        SystemChrome.setPreferredOrientations([rotate?DeviceOrientation.landscapeRight:DeviceOrientation.portraitUp]);
      },
      child:Icon(Icons.screen_rotation,size: 30,color: Colors.white,) ,
    );

  }
}
