import 'dart:math';

import 'package:flutter/foundation.dart';

import '../utilities/utlility.dart';
import './../models/logic_provider.dart';

class PlayVsCPUProvider extends LogicProvider with ChangeNotifier {
  @override
  bool onButtonClick(int id) {
    if (!myTurn) return false;

    bool isChanged = super.onButtonClick(id);
    if (!isChanged) return false;
    myTurn = false;

    bool winner = false;
    winner = super.checkWinner();

    if (winner) {
      showModelScreen = true;
    }
    notifyListeners();

    if (!winner) fillNextButton();

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
    super.resetGame();


    notifyListeners();
  }

  void fillNextButton() {
    if (myTurn == true) return;

    int buttonId = calculateNextMove();
    if (buttonId == -1) return;

    togglePlayer();
    super.onButtonClick(buttonId);

    bool winner = false;
    if (xButtons.length >= 3 || oButtons.length >= 3) {
      winner = super.checkWinner();
    }
    if (winner) {
      myTurn = false;
      showModelScreen = true;
    } else {
      togglePlayer();
      myTurn = true;
    }

    notifyListeners();
  }

  int calculateNextMove() {
    int randomInt;
    List<int> combinedList = List.from(xButtons)..addAll(oButtons);
    if (combinedList.length == 9) return -1;
    while (true) {
      randomInt = Random().nextInt(9) + 1;

      if (!combinedList.contains(randomInt)) {
        break;
      }
    }
    return randomInt;
  }
}
