import 'package:flutter/material.dart';
import 'package:sharedpreferences/listexample.dart';
import 'package:sharedpreferences/numberincrement.dart';
import 'package:sharedpreferences/sharedpreferenceexample.dart';
import 'package:sharedpreferences/todoexample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewtodoApp(),
    );
  }
}
      