import 'package:flutter/material.dart';
import 'package:image_gen/screens/avatar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiceBear API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceBearAvatar(),
    );
  }
}
