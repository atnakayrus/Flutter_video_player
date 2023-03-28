import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import "package:file_manager/file_manager.dart";
class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  FileManagerController controller=FileManagerController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: FileManager(
        controller: controller,
        builder: (context, snapshot) {
          final List<FileSystemEntity> entities = snapshot;
          return ListView.builder(
            itemCount: entities.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: FileManager.isFile(entities[index])
                      ? Icon(Icons.feed_outlined)
                      : Icon(Icons.folder),
                  title: Text(FileManager.basename(entities[index])),
                  onTap: () {
                    if (FileManager.isDirectory(entities[index])) {
                      controller.openDirectory(entities[index]);   // open directory
                    } else {
                      // Perform file-related tasks.
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
    ;
  }
}
