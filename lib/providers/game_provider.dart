import 'package:flutter/foundation.dart';

import './../models/utlility.dart';
import './../models/logic_provider.dart';

class GameProvider extends LogicProvider with ChangeNotifier {

  @override
  bool onButtonClick(int id) {
    bool isChanged = super.onButtonClick(id);

    bool winner = false;
    if (xButtons.length >= 3 || oButtons.length >= 3) {
      winner = super.checkWinner();
    }
    if (winner) {
      myTurn = false;
      showModelScreen = true;
    } else {
      if (isChanged) {
        togglePlayer();
      }
    }

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
    super.resetGame();

    notifyListeners();
  }
}

  // void fillNextButton() {
  //   if (myTurn == true) return;

  //   int buttonId = calculateNextMove();
  //   print(buttonId);

  //   if (playerType == Player.X) {
  //     playerType = Player.O;
  //   } else {
  //     playerType = Player.X;
  //   }
  //   super.onButtonClick(buttonId);
  //   myTurn = true;

  //   notifyListeners();
  // }

  // int calculateNextMove() {
  //   int randomInt;
  //   List<int> combinedList = List.from(xButtons)..addAll(oButtons);
  //   print(combinedList);
  //   while (true) {
  //     randomInt = Random().nextInt(9) + 1;

  //     if (!combinedList.contains(randomInt)) {
  //       break;
  //     }
  //   }
  //   return randomInt;
  // }
