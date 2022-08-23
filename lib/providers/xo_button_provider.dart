// import 'package:flutter/foundation.dart';

// Need to bring the myturn logic inside GameProvider .
// This doesn't work because each widget has its own

enum GameOptions { X, O, none }

class XOButtonProvider {
  int id;
  GameOptions buttontype;
  XOButtonProvider({required this.id, this.buttontype = GameOptions.none});

  String get assetLink {
    if (buttontype == GameOptions.X) {
      return "assets/images/x_filled.svg";
    } else if (buttontype == GameOptions.O) {
      return "assets/images/o_filled.svg";
    } else {
      return "";
    }
  }

  // void onButtonClick() {
  //   if (_myTurn == false) return;

  //   if (_playerType == Player.X) {
  //     buttontype = GameOptions.X;
  //   } else if (_playerType == Player.O) {
  //     buttontype = GameOptions.O;
  //   }
  //   _myTurn = false;
  //   notifyListeners();
  // }
}
