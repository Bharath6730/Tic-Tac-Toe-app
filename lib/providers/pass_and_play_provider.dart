import 'package:flutter/foundation.dart';
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

  @override
  void resetGame() {
    super.resetGame();

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
