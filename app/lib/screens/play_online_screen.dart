import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/playOnline/black_center_button.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/playOnline/dialog_manager.dart';
import 'package:tic_tac_toe/widgets/playOnline/winner_dialog.dart';

class PlayOnlineScreen extends StatelessWidget {
  const PlayOnlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayOnlineProvider>.value(
      value: ModalRoute.of(context)?.settings.arguments as PlayOnlineProvider,
      child: Consumer<PlayOnlineProvider>(builder: (_, value, __) {
        if (value.showWinnerDialog && !value.winnerDialogAlreadyShown) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            value.changeModelToTrue();
            await showAnimatedDialog(
              context: context,
              dialog: OnlinePlayWinnerDialog(
                resetGame: value.resetGame,
                returnFunction: value.quitGame,
                winner: value.winner as ButtonType,
                winnerText:
                    value.didIWIn ? "You Won!" : "${value.opponentName} Wins!",
                provider: value,
              ),
            );
            value.changeModelToFalse();
          });
        }
        if (value.gameState == GameState.opponentLeft ||
            value.gameState == GameState.opponentQuit) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            dialogManager(value, context);
          });
        }

        bool showRoomAnouncement(GameState gameState) {
          if (gameState == GameState.waitingForNextRoundAcceptance ||
              gameState == GameState.waitingForPlayerToJoin ||
              gameState == GameState.waitingForPlayerToJoinAgain) return true;
          return false;
        }

        String announcementText(GameState gameState) {
          if (gameState == GameState.waitingForPlayerToJoin) {
            return "Hey, ${value.myName}. Please ask your friend to enter Game ID: ${value.room}. Waiting for player 2...";
          } else if (value.gameState == GameState.waitingForPlayerToJoinAgain) {
            return "Waiting for Opponent to connect again.. Room Id : ${value.room}";
          } else if (value.gameState ==
              GameState.waitingForNextRoundAcceptance) {
            return "Waiting for ${value.opponentName} to accept play again.";
          }
          return "";
        }

        return PopWithDialog(
          content: "This action declares the opponent as winner.",
          quitTitle: "Quit",
          quitFunction: value.quitGame,
          child: Scaffold(
              appBar: AppBar(
                title: const CenterAppIcon(),
                centerTitle: true,
              ),
              // bottomNavigationBar: BottomNavigationBar(items: const [
              //   BottomNavigationBarItem(
              //       icon: Icon(Icons.games_outlined), label: "Game"),
              //   BottomNavigationBarItem(
              //       icon: Icon(Icons.chat_bubble), label: "Chat"),
              // ]),
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const SizedBox(height: 50),
                    if (showRoomAnouncement(value.gameState))
                      BlackCenterButton(
                          textInside: announcementText(value.gameState))
                    else
                      Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: BlackCenterButton(
                            textInside: (value.myTurn)
                                ? "Your TURN"
                                : "Opponent's TURN",
                          )),
                    GameGrid(xoList: value),
                    const SizedBox(height: 25),
                    GameFooter(
                      xWinCount: value.xWinCount,
                      oWinCount: value.oWinCount,
                      tiesCount: value.tiesCount,
                      xCustomName:
                          value.iAmPlayer1 ? "You" : value.opponentName,
                      oCustomName:
                          value.iAmPlayer1 ? value.opponentName : "You",
                      // onlyName: true,
                    ),
                  ]))),
        );
      }),
    );
  }
}