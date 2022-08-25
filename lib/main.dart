import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

// import './screens/game_screen.dart';
// import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff1f3641),
                shadowColor: Color(0xff10212a)),
            scaffoldBackgroundColor: const Color(0xff1a2a33),
            textTheme: const TextTheme(
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
          "/passAndPlay": (context) => const GameScreen()
        },
      ),
    );
  }
}
