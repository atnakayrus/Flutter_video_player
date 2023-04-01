import 'dart:ffi';
import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/constants/Appstyle.dart';
import 'package:video_player/hives/datafn.dart';
import 'package:video_player/hives/hivefn.dart';

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

  @override
  Widget build(BuildContext context) {
    var ic;
    if (FileManager.isDirectory(widget.entity)) {
      ic = Icons.folder;
    } else {
      String ext = FileManager.getFileExtension(widget.entity);
      if (ext == "png" || ext == "jpg" || ext == "jpeg") {
        String path=widget.entity.path;
        print(path);
        File f=File(path);
        ic = Container(padding:EdgeInsets.all(10),child: Image.file(f));
      } else if (ext == "mp4") {
        ic = Icons.video_collection;
      } else {
        ic = Icons.feed_outlined;
      }
    }
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
      leading: (ic.runtimeType==IconData)?Icon(ic):ic,
      title: Text(FileManager.basename(widget.entity)),
      trailing: fav,
      onTap: () {
        if (FileManager.isDirectory(widget.entity)) {
          widget.controller.openDirectory(widget.entity);
        }
      },
    );
  }
}
