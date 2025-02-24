// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
