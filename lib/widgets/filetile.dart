import 'dart:ffi';
import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
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
    IconData ic;
    if (FileManager.isDirectory(widget.entity)) {
      ic = Icons.folder;
    } else {
      String ext = FileManager.getFileExtension(widget.entity);
      if (ext == "png" || ext == "jpg" || ext == "jpeg") {
        ic = Icons.image;
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
          color: Colors.red),
      onPressed: () {
        if (check) {
          widget.db.folders.remove(widget.entity);
        } else {
          widget.db.folders.add(widget.entity);
        }
        setState(() {
          check = !check;
        });
        print(widget.db.folders);
        print(widget.entity);
        print(check);
      },
    );

    return ListTile(
      leading: Icon(ic),
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
