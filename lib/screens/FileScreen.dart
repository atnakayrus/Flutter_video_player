import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import "package:file_manager/file_manager.dart";
import 'package:video_player/constants/Appstyle.dart';
import 'package:video_player/hives/hivefn.dart';
import 'package:video_player/widgets/filetile.dart';

class FileScreen extends StatefulWidget {
  final DataBase db;
  const FileScreen({super.key, required this.db});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  FileManagerController controller = FileManagerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        foregroundColor: AppStyle.subMainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (controller.isRootDirectory() != true) {
              controller.goToParentDirectory();
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
                return FileTile(
                    entity: entities[index],
                    controller: controller,
                    db: widget.db);
              },
            );
          },
        ),
      ),
    );
    ;
  }
}
