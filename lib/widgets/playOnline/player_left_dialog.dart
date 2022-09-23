import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/dialogs/custom_dialog.dart';

class PlayerLeftDialog extends StatelessWidget {
  final VoidCallback waitForPlayer;
  const PlayerLeftDialog({Key? key, required this.waitForPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        height: 300,
        headerTitle: "Opponent Left the Game",
        headerStyle: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        body: const Text(
            "You can either wait for the player to join again or return to main page.",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center),
        leftButtonTitle: "Return",
        onLeftButtonPress: () {
          Navigator.of(context).pop();
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
        rightButtonTitle: "Wait for Player",
        onRightButtonPress: () {
          Navigator.of(context).pop();
          waitForPlayer();
        });
  }
}
