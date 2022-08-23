import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:tic_tac_toe/models/logic_provider.dart';
// import 'package:tic_tac_toe/models/xo_button_class.dart';

class GameProvider extends LogicProvider with ChangeNotifier {
  @override
  void onButtonClick(int id) {
    super.onButtonClick(id);

    bool winner = false;
    if (xButtons.length >= 3 || oButtons.length >= 3) {
      winner = super.checkWinner(playerType);
    }
    if (winner) {
      myTurn = false;
      // Show TO User
    } else {
      togglePlayer();
    }

    notifyListeners();
  }

  void fillNextButton() {
    if (myTurn == true) return;

    int buttonId = calculateNextMove();
    print(buttonId);

    if (playerType == Player.X) {
      playerType = Player.O;
    } else {
      playerType = Player.X;
    }
    super.onButtonClick(buttonId);
    myTurn = true;

    notifyListeners();
    // onButtonClick(buttonId);
  }

  int calculateNextMove() {
    int randomInt;
    List<int> combinedList = List.from(xButtons)..addAll(oButtons);
    print(combinedList);
    while (true) {
      randomInt = Random().nextInt(9) + 1;

      if (!combinedList.contains(randomInt)) {
        break;
      }
    }
    return randomInt;
  }

  void togglePlayer() {
    if (playerType == Player.X) {
      playerType = Player.O;
    } else {
      playerType = Player.X;
    }
  }
}


// class GameProvider with ChangeNotifier {
//   Player _playerType = Player.X;
//   bool _myTurn = true;

//   final List<XOButtonProvider> _data = List.generate(9, (index) {
//     return XOButtonProvider(id: index, buttontype: ButtonType.none);
//   });

//   List<XOButtonProvider> getData() {
//     return [..._data];
//   }

//   String assetLink(int id) {
//     XOButtonProvider button = _data.firstWhere((element) => element.id == id);
//     var buttontype = button.buttontype;
//     if (buttontype == ButtonType.X) {
//       return "assets/images/x_filled.svg";
//     } else if (buttontype == ButtonType.O) {
//       return "assets/images/o_filled.svg";
//     } else {
//       return "";
//     }
//   }

//   // Player checkForWin() {
//   //   return ;
//   // }

//   void onButtonClick(int id) {
//     XOButtonProvider button = _data.firstWhere((element) => element.id == id);

//     if (_myTurn == false) return;
//     if (button.buttontype != ButtonType.none) return;

//     if (_playerType == Player.X) {
//       button.buttontype = ButtonType.X;
//     } else {
//       button.buttontype = ButtonType.O;
//     }
//     button.buttontype = button.buttontype;
//     // _myTurn = false;
//     if (_playerType == Player.X) {
//       _playerType = Player.O;
//     } else {
//       _playerType = Player.X;
//     }

//     notifyListeners();
//   }
// }
