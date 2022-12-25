import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/router.dart' as router;

LocalStorageProvider _sp = LocalStorageProvider();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _sp.initaliaze();
  runApp(const MyApp());
}
// TODO : Refactor all the repeated code.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalStorageProvider>.value(
      value: _sp,
      child: MaterialApp(
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
          onGenerateRoute: router.generateRoute),
    );
  }
}