import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List<FileSystemEntity> folders = [];
  List<FileSystemEntity> files = [];
  final _mybox = Hive.box('Fave');

  void createInitialData() {
    updateData();
  }

  void loadData() {
    folders = _mybox.get('folders');
    files = _mybox.get('files');
  }

  void updateData() {
    _mybox.put('folders', folders);
    _mybox.put('files', files);
  }
}
