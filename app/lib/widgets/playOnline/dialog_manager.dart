import 'package:flutter/material.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider_renewed.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/dialogs/custom_dialog.dart';
import 'package:tic_tac_toe/widgets/dialogs/dialog_container.dart';

void dialogManager(PlayOnlineProvider provider, BuildContext context) {
  GameState gameState = provider.gameState;
  if (gameState == GameState.opponentQuit) {
    showAnimatedDialog(
        context: context,
        dialog: PlayerQuitDialog(
          onPressed: provider.quitGame,
        ));
  } else if (gameState == GameState.opponentLeft) {
    showAnimatedDialog(
        context: context,
        dialog: PlayerLeftDialog(
          waitForPlayer: provider.waitForPlayer,
          quit: provider.quitGame,
        ));
  }
}

class PlayerLeftDialog extends StatelessWidget {
  final VoidCallback waitForPlayer;
  final VoidCallback quit;
  const PlayerLeftDialog(
      {Key? key, required this.waitForPlayer, required this.quit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
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
        onLeftButtonPress: quit,
        rightButtonTitle: "Wait for Player",
        onRightButtonPress: () {
          Navigator.of(context).pop();
          waitForPlayer();
        });
  }
}

class PlayerQuitDialog extends StatelessWidget {
  final VoidCallback onPressed;
  const PlayerQuitDialog({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
        header: const Text("You Won!",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center),
        body: const Text(
          "Opponent has quit the game.",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white54),
          textAlign: TextAlign.center,
        ),
        footer: SubmitButton(
          backgroundColor: AppTheme.silverButtonColor,
          shadowColor: AppTheme.silverShadowColor,
          splashColor: AppTheme.silverHoverColor,
          radius: 15,
          onPressed: onPressed,
          child: Text(
            "EXIT",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
