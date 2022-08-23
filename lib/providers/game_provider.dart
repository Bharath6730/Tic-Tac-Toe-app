import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/providers/xo_button_provider.dart';

enum Player { X, O }

class GameProvider with ChangeNotifier {
  Player _playerType = Player.O;
  bool _myTurn = true;

  List<XOButtonProvider> _data = List.generate(9, (index) {
    return XOButtonProvider(id: index, buttontype: GameOptions.none);
  });

  List<XOButtonProvider> getData() {
    return [..._data];
  }

  // void changeData(int id,GameOptions options){
  //   _data.where((element) => )
  // }

  String assetLink(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    var buttontype = button.buttontype;
    if (buttontype == GameOptions.X) {
      return "assets/images/x_filled.svg";
    } else if (buttontype == GameOptions.O) {
      return "assets/images/o_filled.svg";
    } else {
      return "";
    }
  }

  void onButtonClick(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    // GameOptions buttontype = button.buttontype;
    if (_myTurn == false) return;

    if (_playerType == Player.X) {
      button.buttontype = GameOptions.X;
    } else {
      button.buttontype = GameOptions.O;
    }
    button.buttontype = button.buttontype;
    _myTurn = false;

    notifyListeners();
  }
}
