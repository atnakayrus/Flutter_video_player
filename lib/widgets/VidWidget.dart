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

class _VidWidgetState extends State<VidWidget> with SingleTickerProviderStateMixin{
  late VideoPlayerController _controller;
  bool active=true;
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
  return WillPopScope(
    onWillPop: ()async{
      return true;
    },
    child: GestureDetector(
      onTap: (){
        setState(() {
          active=!active;
        });
        },
      child: Container(
        child: _controller.value.isInitialized?
            Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller)
                  )
              ),
                  fading_widget(),
            ],
            )
            :
         const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
}

  fading_widget() {
    // Future.delayed(Duration(seconds: 5), (){
    //   active=true;
    // });
    return AnimatedOpacity(
        opacity: active?0.0:1.0,
        duration: Duration(milliseconds: 100),
        child: OverlayWidget(controller: _controller));
  }

}
