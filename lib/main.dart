import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snap/HomePage.dart';
import 'package:snap/StartPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snappy',
      color: Colors.blue,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

// Face Recognisation
