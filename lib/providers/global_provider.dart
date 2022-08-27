import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import './../models/utlility.dart';
import './../models/logic_provider.dart';

class GlobalProvider extends LogicProvider with ChangeNotifier {
  GameMode _gameMode = GameMode.passAndPlay;

  void changeGameMode(GameMode newGameMode) {
    _gameMode = newGameMode;
    notifyListeners();
  }

  LogicProvider get getGameMode {
    return GameProvider();
  }
}
