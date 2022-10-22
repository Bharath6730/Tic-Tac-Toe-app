import 'package:flutter/foundation.dart';
import './../models/logic_provider.dart';

class PassAndPlayProvider extends LogicProvider with ChangeNotifier {
  PassAndPlayProvider({required playerType}) {
    this.playerType = playerType;
  }

  @override
  bool onButtonClick(int id) {
    if (winner != null) {
      showWinnerDialog = true;
      notifyListeners();
      return false;
    }

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

  @override
  void completeReset() {
    super.completeReset();
    super.resetGame();

    notifyListeners();
  }

  void passAndPlayButtonClick(bool isChanged) {
    bool winner = false;

    winner = super.checkWinner();

    if (winner) {
      myTurn = false;
      showWinnerDialog = true;
    } else {
      if (isChanged) {
        togglePlayer();
      }
    }
  }
}
