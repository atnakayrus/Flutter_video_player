import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/hives/hivefn.dart';
import 'package:flutter_video_player/screens/FileScreen.dart';
import 'package:flutter_video_player/widgets/filetile.dart';

class FavScreen extends StatefulWidget {
  final DataBase db;
  final Function onTap;
  const FavScreen({super.key, required this.db, required this.onTap});
  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  FileManagerController controller = FileManagerController();

  @override
  Widget build(BuildContext context) {
    int len = widget.db.folders.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
        backgroundColor: AppStyle.mainColor,
        foregroundColor: AppStyle.subMainColor,
      ),
      drawer: Drawer(backgroundColor: AppStyle.mainColor),
      body: Container(
        color: AppStyle.accentColor,
        child: ListView.builder(
            itemCount: len,
            itemBuilder: (context, index) {
              FileSystemEntity entity = File(widget.db.folders[index].path);
              return ListTile(
                textColor: AppStyle.subAccentColor,
                iconColor: AppStyle.subAccentColor,
                title: Text(FileManager.basename(entity)),
                onTap: () async {
                  bool reload = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FileScreen(
                              db: widget.db,
                              path: widget.db.folders[index].path,
                            )),
                  );
                  if (reload) {
                    setState(() {});
                  }
                },
              );
            }),
      ),
    );
  }
}
