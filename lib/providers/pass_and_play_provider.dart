import 'package:flutter/foundation.dart';

import '../utilities/utlility.dart';
import './../models/logic_provider.dart';

class PassAndPlayProvider extends LogicProvider with ChangeNotifier {
  @override
  bool onButtonClick(int id) {
    if (myTurn == false) return false;

    bool isChanged = super.onButtonClick(id);

    passAndPlayButtonClick(isChanged);

    notifyListeners();
    return isChanged;
  }

  void togglePlayer() {
    if (playerType == Player.X) {
      playerType = Player.O;
    } else {
      playerType = Player.X;
    }
  }

  @override
  void resetGame() {
    // Who started first
    if (xButtons.length > oButtons.length) {
      print("X started first");
    } else if (oButtons.length > xButtons.length) {
      print("O started first");
    } else {
      if (playerType == Player.X) {
        print("X started first");
      } else {
        print("O started first");
      }
    }
    super.resetGame();

    print(playerType);
    print(winner);
    notifyListeners();
  }

  void passAndPlayButtonClick(bool isChanged) {
    bool winner = false;

    winner = super.checkWinner();

    if (winner) {
      myTurn = false;
      showModelScreen = true;
    } else {
      if (isChanged) {
        togglePlayer();
      }
    }
  }
}
