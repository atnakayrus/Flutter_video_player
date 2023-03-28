import 'package:flutter/material.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      drawer: Drawer(backgroundColor: Colors.blue),
      body: Container(
        color: Colors.red,
        child: const Text('hello'),
      ),
    );
  }
}
