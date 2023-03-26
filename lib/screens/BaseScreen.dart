import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
      ),
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
      ),
    );
  }
}
