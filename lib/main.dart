// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/homePage.dart';
import 'package:logger/logger.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _logger = Logger();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIManager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
