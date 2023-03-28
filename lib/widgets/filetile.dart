import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  final FileSystemEntity entity;
  final FileManagerController controller;
  const FileTile({super.key, required this.entity, required this.controller});

  @override
  Widget build(BuildContext context) {
    IconData ic;
    if (FileManager.isDirectory(entity)) {
      ic = Icons.folder;
    } else {
      String ext = FileManager.getFileExtension(entity);
      if (ext == "png" || ext == "jpg" || ext == "jpeg") {
        ic = Icons.image;
      } else if (ext == "mp4") {
        ic = Icons.video_collection;
      } else {
        ic = Icons.feed_outlined;
      }
    }
    return ListTile(
      leading: Icon(ic),
      title: Text(FileManager.basename(entity)),
      onTap: () {
        if (FileManager.isDirectory(entity)) {
          controller.openDirectory(entity);
        }
      },
    );
  }
}
