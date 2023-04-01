import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List<FileSystemEntity> folders = [];
  List folderPaths = [];
  final _mybox = Hive.box('Fave');

  void createInitialData() {
    updateData();
    print('hello');
  }

  void loadData() {
    folderPaths = _mybox.get('folders');
    print(folderPaths);
    for (int i = 0; i < folderPaths.length; i++) {
      folders.add(Directory(folderPaths[i]));
    }
  }

  void updateData() {
    folderPaths = [];
    for (int i = 0; i < folders.length; i++) {
      folderPaths.add(folders[i].path);
    }
    _mybox.put('folders', folderPaths);
  }
}
