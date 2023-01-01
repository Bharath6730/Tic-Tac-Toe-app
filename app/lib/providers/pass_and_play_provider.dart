import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import './../models/logic_provider.dart';

class PassAndPlayProvider extends LogicProvider with ChangeNotifier {
  PassAndPlayProvider({
    required playerType,
  }) : super(
          gameMode: GameMode.passAndPlay,
        ) {
    this.playerType = playerType;
  }

  @override
  bool onButtonClick(int id) {
    if (winner != WinnerType.none) {
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
    bool winners = false;

    winners = super.checkWinner();

    if (winners) {
      myTurn = false;
      showWinnerDialog = true;
    } else {
      if (isChanged) {
        togglePlayer();
      }
    }
    if (winner != WinnerType.none) {
      // incrementKey("games");
    }
  }
}
