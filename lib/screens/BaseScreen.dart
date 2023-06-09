import 'package:flutter/material.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';
import 'package:flutter_video_player/screens/FileScreen.dart';
import 'package:flutter_video_player/screens/WebScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hives/hivefn.dart';
import 'FavScreen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  String basePath = '';
  void selectedItem(int index) {
    setState(() {
      _selectedIndex = index;
      basePath = '';
    });
  }

  void navigateToFile(String path) {
    basePath = path;
  }

  final _myBox = Hive.box('Fave');
  DataBase db = DataBase();
  @override
  void initState() {
    if (_myBox.get('folders') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  Widget currentScreen() {
    if (_selectedIndex == 1) {
      return FileScreen(
        db: db,
        path: '',
      );
    } else if (_selectedIndex == 2) {
      return WebScreen();
    }
    return FavScreen(
      db: db,
      onTap: navigateToFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppStyle.mainColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: AppStyle.subAccentColor,
            ),
            label: 'Favs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: AppStyle.subAccentColor,
            ),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: AppStyle.subAccentColor,
            ),
            label: 'web',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: selectedItem,
      ),
    );
  }
}
