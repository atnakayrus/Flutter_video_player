import 'dart:io';

class DataFunctions {
  bool isFav(FileSystemEntity entity, List<FileSystemEntity> fav) {
    bool check = false;
    for (int i = 0; i < fav.length; i++) {
      if (fav[i].path == entity.path) {
        check = true;
        break;
      }
    }
    return (check);
  }

  List<FileSystemEntity> addEle(
      FileSystemEntity entity, List<FileSystemEntity> fav) {
    fav.add(entity);
    return (fav);
  }

  List<FileSystemEntity> removeEle(
      FileSystemEntity entity, List<FileSystemEntity> fav) {
    for (int i = 0; i < fav.length; i++) {
      if (fav[i].path == (entity.path)) {
        fav.removeAt(i);
        break;
      }
    }
    return (fav);
  }
}
