import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/dialogs/custom_dialog.dart';

Widget restartDialog(
    {required BuildContext context, required VoidCallback restartFunction}) {
  return CustomDialog(
      height: 270,
      headerTitle: "Restart Game?",
      body: const Text(
        "This will reset all the current game data including each player's win count.",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white54),
        textAlign: TextAlign.center,
      ),
      leftButtonTitle: "Cancel",
      onLeftButtonPress: () => Navigator.of(context).pop("cancel"),
      rightButtonTitle: "Restart",
      onRightButtonPress: () {
        Navigator.of(context).pop();
        restartFunction();
      });
}
