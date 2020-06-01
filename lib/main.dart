import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterapp/TakeOutMethod.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: new ThemeData(primaryColor: Colors.white),
        home: new RandomWords());
  }
}
