import 'package:flutter/material.dart';

import 'package:tic_tac_toe/screens/pass_and_play_screen.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/play_online_screen.dart';
import 'package:tic_tac_toe/screens/play_vs_cpu_screen.dart';

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
      theme: ThemeData(
          fontFamily: "Outfit",
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff1f3641),
              shadowColor: Color(0xff10212a)),
          scaffoldBackgroundColor: const Color(0xff1a2a33),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.black),
              bodyMedium: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black),
              bodySmall: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black))),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/passAndPlay": (context) => const PassAndPlayScreen(),
        "/playVsCPU": (context) => const PlayVsCPUScreen(),
        "/playOnline": (context) => const PlayOnlineScreen(),
      },
    );
  }
}
