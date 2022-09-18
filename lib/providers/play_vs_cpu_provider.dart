import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

import './../models/logic_provider.dart';

class PlayVsCPUProvider extends LogicProvider with ChangeNotifier {
  Player myPlayerType = Player.X;
  Player whoStartedFirst = Player.X;
  PlayVsCPUProvider(Player player) {
    if (player == Player.X) {
      return;
    }
    myPlayerType = Player.O;
    playerType = Player.O;
    cpuStartsGame();
  }
  bool didIWin = false;
  @override
  bool onButtonClick(int id) {
    if (!myTurn) return false;

    bool isChanged = super.onButtonClick(id);
    if (!isChanged) return false;
    myTurn = false;

    bool checkWinner = false;
    checkWinner = super.checkWinner();

    if (checkWinner) {
      showModelScreen = true;
      didIWin = true;
    }
    notifyListeners();

    if (!checkWinner) fillNextButton();

    return isChanged;
  }

  @override
  void resetGame() {
    super.resetGame();

    notifyListeners();

    // print(whoStartedFirst);
    // print(playerType);
    whoStartedFirst = whoStartedFirst == Player.X ? Player.O : Player.X;
    // playerType = whoStartedFirst == Player.X ? Player.X : Player.O;

    print(whoStartedFirst);
    print(playerType);

    if (whoStartedFirst != myPlayerType) {
      print("CPU starts ${playerType}");
      cpuStartsGame();
    } else {
      myTurn = true;
      notifyListeners();
    }
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
      didIWin = false;
    } else {
      myTurn = true;
    }
    togglePlayer();

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

  void cpuStartsGame() {
    myTurn = false;
    fillNextButton();
  }
}
