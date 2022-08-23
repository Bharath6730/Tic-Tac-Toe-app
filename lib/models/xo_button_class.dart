enum ButtonType { X, O, none }

class XOButtonProvider {
  int id;
  ButtonType buttontype;
  bool isWinnerButton = false;
  XOButtonProvider({required this.id, this.buttontype = ButtonType.none});
}
