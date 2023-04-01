import 'package:flutter/material.dart';
import 'package:flutter_video_player/constants/Appstyle.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.accentColor,
      child: const Text('hello'),
    );
  }
}
