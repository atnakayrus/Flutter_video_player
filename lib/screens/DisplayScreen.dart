import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/widgets/VidWidget.dart';
import 'package:video_player/video_player.dart';

class DisplayScreen extends StatefulWidget {
  final FileSystemEntity entity;
  const DisplayScreen({Key? key, required this.entity}) : super(key: key);
  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {

  Widget? display() {
    String ext = FileManager.getFileExtension(widget.entity);
    if (ext == "png" || ext == "jpg" || ext == "jpeg") {
      return Image.file(File(widget.entity.path));
    }
    else if(ext=="mp4"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  VidWidget(entity: widget.entity,)),
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.accentColor,
      ),
      child: display(),
    );
  }
}
