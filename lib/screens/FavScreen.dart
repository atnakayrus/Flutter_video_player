import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/hives/hivefn.dart';
import 'package:flutter_video_player/widgets/filetile.dart';

class FavScreen extends StatefulWidget {
  final DataBase db;
  const FavScreen({super.key, required this.db});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
        backgroundColor: AppStyle.mainColor,
        foregroundColor: AppStyle.subMainColor,
      ),
      drawer: Drawer(backgroundColor: AppStyle.mainColor),
      body: Container(
        color: AppStyle.accentColor,
        child: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return ListView.builder(
              itemCount: widget.db.folders.length,
              itemBuilder: (context, index) {
                return FileTile(
                    entity: widget.db.folders[index],
                    controller: controller,
                    db: widget.db);
              },
            );
          },
        ),
      ),
    );
  }
}
