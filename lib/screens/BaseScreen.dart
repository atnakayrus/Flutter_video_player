import 'package:flutter/material.dart';
import 'package:video_player/screens/FileScreen.dart';
import 'package:video_player/screens/WebScreen.dart';

import 'FavScreen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex=0;
  void SelectedItem(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  Widget currentScreen(){
    if(_selectedIndex==1){
      return FileScreen();
    }
    else if(_selectedIndex==2){
      return WebScreen();
    }
    return FavScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
      ),
      body: currentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'web',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: SelectedItem,
      ),
    );
  }
}
