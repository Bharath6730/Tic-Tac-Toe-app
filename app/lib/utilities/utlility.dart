import 'package:flutter/material.dart';

enum GameMode { passAndPlay, playVsCPU, playOnline }

enum ButtonType { X, O, none }

enum Player { X, O }

enum GameState {
  idle,
  creating,
  joining,
  playing,
  waitingForPlayerToJoin,
  opponentLeft,
  waitingForPlayerToJoinAgain,
  waitingForNextRoundAcceptance,
  opponentQuit
}


String getAssetLink(ButtonType buttonType) {
  if (buttonType == ButtonType.none) return "";
  if (buttonType == ButtonType.X) return "assets/images/x_filled.svg";
  return "assets/images/o_filled.svg";
}

class AppTheme {
  static const Color xbuttonColor = Color(0xff31c3bd);
  static const Color xHoverColor = Color(0xff65e9e4);
  static const Color xShadowColor = Color(0xff118c87);

  static const Color oButtonColor = Color(0xfff2b137);
  static const Color oHoverColor = Color(0xffffc860);
  static const Color oShadowColor = Color(0xffcc8b13);

  static const Color silverButtonColor = Color(0xffa8bfc9);
  static const Color silverHoverColor = Color(0xffdbe8ed);
  static const Color silverShadowColor = Color(0xff6b8997);

  static const Color darkShadow = Color(0xff10212a);
  static const Color dialogColor = Color(0xff1f3641);
  static const Color darkBackground = Color(0xff1a2a33);
}
