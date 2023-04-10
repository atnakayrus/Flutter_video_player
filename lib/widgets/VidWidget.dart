import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_video_player/widgets/OverlayWidget.dart";
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
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
  return Container(
    child: _controller.value.isInitialized?
        Stack(
            children: [
              // Positioned(
              //   top: 20,
              //   left: 0,
              //   right: 0,
              //   child: GestureDetector(
              //     child: Icon(Icons.arrow_back,color: Colors.white,),
              //     onTap: (){
              //       Navigator.pop(context);
              //       },
              //   ),
              // ),
              Container(
                  alignment: Alignment.center,
                  child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller)
              )
          ),
          Positioned.fill(child:OverlayWidget(controller: _controller))
        ],
        )
        :
     const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
}
