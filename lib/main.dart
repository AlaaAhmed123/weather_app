import 'package:flutter/material.dart';
import 'package:simpleweatherapp/screens/home.dart';
import 'package:simpleweatherapp/screens/loading_screen.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Weather app',
      home: LoadingScreen(),
    );
  }
}
