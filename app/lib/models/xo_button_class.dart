import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe/utilities/enums.dart';

class XOButtonProvider with ChangeNotifier {
  int id;
  ButtonType buttontype;
  bool isWinnerButton = false;
  XOButtonProvider({required this.id, this.buttontype = ButtonType.none});

  void changeButtonData(ButtonType type) {
    buttontype = type;
    notifyListeners();
  }

  void isWinner(bool type) {
    isWinnerButton = type;
    notifyListeners();
  }
}
