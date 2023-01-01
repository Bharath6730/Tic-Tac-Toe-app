import 'package:flutter/material.dart';

import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/login_screen.dart';
import 'package:tic_tac_toe/screens/pass_and_play_screen.dart';
import 'package:tic_tac_toe/screens/play_online_screen.dart';
import 'package:tic_tac_toe/screens/play_vs_cpu_screen.dart';
import 'package:tic_tac_toe/widgets/playOnline/welcome_widget.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/login":
      {
        return animatedPage(const LoginScreen(), settings);
      }
    case "/home":
      {
        return animatedPage(const HomeScreen(), settings);
      }
    case "/passAndPlay":
      {
        return animatedPage(const PassAndPlayScreen(), settings);
      }
    case "/playVsCPU":
      {
        return animatedPage(const PlayVsCPUScreen(), settings);
      }

    case "/playOnline":
      {
        return animatedPage(const OnlinePlayWelcomeWidget(), settings);
      }
    case "/playOnlineGameScreen":
      {
        return animatedPage(const PlayOnlineScreen(), settings);
      }

    default:
      return null;
  }
}

PageRouteBuilder<dynamic> animatedPage(Widget screen, RouteSettings settings) {
  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
