import './xo_button_class.dart';

enum Player { X, O }

class LogicProvider {
  Player playerType = Player.X;
  bool myTurn = true;

  List<int> xButtons = [];
  List<int> oButtons = [];

  final List<XOButtonProvider> _data = List.generate(9, (index) {
    return XOButtonProvider(id: index + 1, buttontype: ButtonType.none);
  });

  List<List<int>> winChanceList = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
  ];

  List<XOButtonProvider> getData() {
    return [..._data];
  }

  ButtonType getButtonType(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    return button.buttontype;
  }

  String getAssetLink(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    var buttonType = button.buttontype;
    if (buttonType == ButtonType.X) {
      return "assets/images/x_filled.svg";
    } else if (buttonType == ButtonType.O) {
      return "assets/images/o_filled.svg";
    } else {
      return "";
    }
  }

  void onButtonClick(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);

    if (myTurn == false) return;
    if (button.buttontype != ButtonType.none) return;

    if (playerType == Player.X) {
      print("XPlayer ${button.buttontype}");
      button.buttontype = ButtonType.X;
      xButtons.add(id);
    } else {
      print("OPlayer ${button.buttontype}");
      button.buttontype = ButtonType.O;
      oButtons.add(id);
    }
  }

  bool checkWinner(Player player) {
    bool ans = false;
    List<int> answerList = [];

    for (int i = 0; i < winChanceList.length; i++) {
      List<int> winList = winChanceList[i];
      int count = 0;
      for (int j = 0; j < winList.length; j++) {
        int winInt = winList[j];
        if (player == Player.X) {
          if (xButtons.contains(winInt)) {
            count++;
          }
        } else {
          if (oButtons.contains(winInt)) {
            count++;
          }
        }
      }
      if (count == 3) {
        ans = true;
        answerList = winList;
        break;
      }
    }

    if (ans) {
      for (var id in answerList) {
        XOButtonProvider button =
            _data.firstWhere((element) => element.id == id);
        button.isWinnerButton = true;
      }
    }
    return ans;
  }

  bool isWinnerButton(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    return button.isWinnerButton;
  }
}
