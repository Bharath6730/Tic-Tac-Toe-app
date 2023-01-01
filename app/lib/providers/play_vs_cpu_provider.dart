import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/utilities/enums.dart';

import './../models/logic_provider.dart';

class PlayVsCPUProvider extends LogicProvider with ChangeNotifier {
  Player myPlayerType = Player.X;
  Player whoStartedFirst = Player.X;
  PlayVsCPUProvider({required Player player})
      : super(gameMode: GameMode.playVsCPU) {
    if (player == Player.X) {
      return;
    }
    myPlayerType = Player.O;
    playerType = Player.O;
    whoStartedFirst = Player.O;
    cpuStartsGame();
  }
  bool didIWin = false;
  @override
  bool onButtonClick(int id) {
    if (winner != WinnerType.none) {
      showWinnerDialog = true;
      notifyListeners();
      return false;
    }

    if (!myTurn) return false;

    bool isChanged = super.onButtonClick(id);
    if (!isChanged) return false;
    myTurn = false;

    bool checkWinner = false;
    checkWinner = super.checkWinner();

    if (checkWinner) {
      showWinnerDialog = true;
      didIWin = true;
    }
    notifyListeners();

    if (!checkWinner) fillNextButton();

    return isChanged;
  }

  @override
  void completeReset() {
    super.completeReset();
    super.resetGame();

    notifyListeners();

    if (myPlayerType != whoStartedFirst) {
      cpuStartsGame();
    }
  }

  @override
  void resetGame() {
    super.resetGame();

    notifyListeners();

    whoStartedFirst = whoStartedFirst == Player.X ? Player.O : Player.X;

    if (whoStartedFirst != myPlayerType) {
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

    bool isWinner = false;
    if (xButtons.length >= 3 || oButtons.length >= 3) {
      isWinner = super.checkWinner();
    }
    if (isWinner) {
      myTurn = false;
      showWinnerDialog = true;
      didIWin = false;
    } else {
      myTurn = true;
    }
    // bool winner = false;
    // if (xButtons.length >= 3 || oButtons.length >= 3) {
    //   winner = super.checkWinner();
    // }
    // if (winner) {
    //   myTurn = false;
    //   showWinnerDialog = true;
    //   didIWin = false;
    // } else {
    //   myTurn = true;
    // }
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
