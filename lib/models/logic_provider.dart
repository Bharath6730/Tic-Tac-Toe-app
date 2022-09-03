import '../utilities/utlility.dart';
import 'xo_button_class.dart';

class LogicProvider {
  ButtonType winner = ButtonType.X;

  Player playerType = Player.X;
  bool myTurn = true;
  bool showModelScreen = false;

  List<int> xButtons = [];
  List<int> oButtons = [];

  int xWinCount = 0;
  int tiesCount = 0;
  int oWinCount = 0;

  List<XOButtonProvider> _data = List.generate(9, (index) {
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

  bool onButtonClick(int id) {
    bool isChanged = false;
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);

    // if (myTurn == false) return isChanged;
    if (button.buttontype != ButtonType.none) return isChanged;

    if (playerType == Player.X) {
      button.changeButtonData(ButtonType.X);
      xButtons.add(id);
    } else {
      button.changeButtonData(ButtonType.O);
      oButtons.add(id);
    }
    isChanged = true;
    return isChanged;
  }

  bool checkWinner() {
    bool ans = false;
    List<int> answerList = [];

    if (xButtons.length < 3 && oButtons.length < 3) return ans;

    for (int i = 0; i < winChanceList.length; i++) {
      List<int> winList = winChanceList[i];
      int count = 0;
      for (int j = 0; j < winList.length; j++) {
        int winInt = winList[j];
        if (playerType == Player.X) {
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

        if (playerType == Player.X) {
          winner = ButtonType.X;
          xWinCount += 1;
        } else {
          winner = ButtonType.O;
          oWinCount += 1;
        }

        break;
      }
    }

    if (ans) {
      for (var id in answerList) {
        XOButtonProvider button =
            _data.firstWhere((element) => element.id == id);
        button.isWinnerButton = true;
      }
    } else {
      if (xButtons.length + oButtons.length == 9) {
        winner = ButtonType.none;
        showModelScreen = true;
        tiesCount = tiesCount + 1;
        return ans;
      }
    }

    return ans;
  }

  bool isWinnerButton(int id) {
    XOButtonProvider button = _data.firstWhere((element) => element.id == id);
    return button.isWinnerButton;
  }

  void resetGame() {
    _data = List.generate(9, (index) {
      return XOButtonProvider(id: index + 1, buttontype: ButtonType.none);
    });

    myTurn = true;
    showModelScreen = false;

    xButtons = [];
    oButtons = [];
  }

  void togglePlayer() {
    if (playerType == Player.X) {
      playerType = Player.O;
    } else {
      playerType = Player.X;
    }
  }
}
