import 'package:flutter/material.dart';

import 'package:jogo_da_velha/pages/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JOGO DA IDOSA',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}