import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoease/screens/home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoEase',
      home: Home(),
      
    );
  }
}
