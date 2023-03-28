import 'dart:io';

class DataFunctions {
  bool isFav(FileSystemEntity entity, List fav) {
    bool check = false;
    for (int i = 0; i < fav.length; i++) {
      if (fav[i].path == entity.path) {
        check = true;
        break;
      }
    }
    return (check);
  }
}
