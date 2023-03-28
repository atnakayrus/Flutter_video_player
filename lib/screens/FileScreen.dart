import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import "package:file_manager/file_manager.dart";
import 'package:video_player/widgets/filetile.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  FileManagerController controller = FileManagerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (controller.isRootDirectory() != true) {
              controller.goToParentDirectory();
            }
          },
        ),
      ),
      body: Container(
        color: Colors.yellow,
        child: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return ListView.builder(
              itemCount: entities.length,
              itemBuilder: (context, index) {
                return FileTile(
                    entity: entities[index], controller: controller);
              },
            );
          },
        ),
      ),
    );
    ;
  }
}
