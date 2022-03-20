import 'package:flutter/material.dart';
import 'package:youtube_downloader/pages/main/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omid Youtube Downloader',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MainScreen(),
    );
  }
}

