import 'dart:io';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/hives/datafn.dart';
import 'package:flutter_video_player/hives/hivefn.dart';
import 'package:flutter_video_player/screens/DisplayScreen.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileTile extends StatefulWidget {
  final FileSystemEntity entity;
  final FileManagerController controller;
  final DataBase db;
  const FileTile(
      {super.key,
      required this.entity,
      required this.controller,
      required this.db});

  @override
  State<FileTile> createState() => _FileTileState();
}

class _FileTileState extends State<FileTile> {
  late VideoPlayerController vid_cont;
  var res;
  var ic;
  bool loaded=false,selected=false;
  String? thumbnailFile;
  Future<void> get_video_thumbnail(String path,Directory dir) async {
     res=await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.JPEG,
      thumbnailPath: dir.path,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
  setState(() {
    loaded=true;
  });
  }
  Future<void> getIcon() async {
    if (FileManager.isDirectory(widget.entity)) {
      ic = Icons.folder;
    } else {
      String ext = FileManager.getFileExtension(widget.entity);
      String path = widget.entity.path;
      File f = File(path);
      if (ext == "png" || ext == "jpg" || ext == "jpeg") {
        ic = Container(padding: const EdgeInsets.all(10), child: Image.file(f));
      } else if (ext == "mp4") {
        var temp=Directory.systemTemp;
        get_video_thumbnail(path,temp);
        if (res != null) {
          print("The output");
          print(res);
          File t = File(res);
          ic = loaded?Container(padding: const EdgeInsets.all(10), child: Image.file(t)):const CircularProgressIndicator();
        }
      }
      else {
        ic = Icons.feed_outlined;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getIcon();
    DataFunctions df = DataFunctions();
    bool check = df.isFav(widget.entity, widget.db.folders);
    IconButton fav = IconButton(
      icon: Icon(check ? Icons.favorite : Icons.favorite_border,
          color: AppStyle.subAccentColor),
      onPressed: () {
        // print(check);
        if (check) {
          widget.db.folders = df.removeEle(widget.entity, widget.db.folders);
        } else {
          widget.db.folders = df.addEle(widget.entity, widget.db.folders);
        }
        setState(() {
          check = !check;
        });
        // print(widget.db.folders);
        // print(widget.entity);
        // print(check);
        widget.db.updateData();
      },
    );

    return ListTile(
      textColor: AppStyle.subAccentColor,
      iconColor: AppStyle.subAccentColor,
      tileColor: AppStyle.accentColor,
      leading: (ic.runtimeType == IconData) ? Icon(ic) : ic,
      title: Text(FileManager.basename(widget.entity)),
      onTap: () {
        if (FileManager.isDirectory(widget.entity)) {
          widget.controller.openDirectory(widget.entity);
        }
        else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  DisplayScreen(entity: widget.entity)),
            );
        }
      },

    );
  }
}
