import 'package:flutter/material.dart';

import './screens/game_screen.dart';
// import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff1f3641),
              shadowColor: Color(0xff10212a)),
          // scaffoldBackgroundColor: Colors.blue,
          scaffoldBackgroundColor: const Color(0xff1a2a33)),
      home: const GameScreen(),
    );
  }
}
