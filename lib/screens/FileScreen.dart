import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import "package:file_manager/file_manager.dart";
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/hives/hivefn.dart';
import 'package:flutter_video_player/widgets/filetile.dart';
import 'package:permission_handler/permission_handler.dart';

class FileScreen extends StatefulWidget {
  final DataBase db;
  final String path;
  const FileScreen({super.key, required this.db, required this.path});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  FileManagerController controller = FileManagerController();
  var status=false;
  Future<void> getPerm() async {
    status = await Permission.storage.request().isGranted;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPerm();
  }
  @override
  void initState() {
    controller.setCurrentPath = widget.path;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        foregroundColor: AppStyle.subMainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (await controller.isRootDirectory() != true) {
              controller.goToParentDirectory();
            } else {
              print('should pop');
              if (Navigator.canPop(context) == true) {
                Navigator.pop(context, true);
              }
            }
          },
        ),
      ),
      body: Container(
        color: AppStyle.accentColor,
        child: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return ListView.builder(
              itemCount: entities.length,
              itemBuilder: (context, index) {

                if(status==true) {
                  return FileTile(
                      entity: entities[index],
                      controller: controller,
                      db: widget.db
                  );
                }
                return null;
              },
            );
          },
        ),
      ),
    );
    ;
  }
}
