import 'package:flutter/material.dart';

import 'views/addCategories.dart';
import 'views/mainScreen.dart';
import 'views/showCategories.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainScreen(),
      routes: {
        "showCat": (context) => showCategories(),
        "addCat": (context) => addCategories(),
        "mainScreen": (context) => mainScreen(),
      },
    );
  }
}