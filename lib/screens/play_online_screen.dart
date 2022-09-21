import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/widgets/playOnline/black_center_button.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/playOnline/modal_widget.dart';
import 'package:tic_tac_toe/widgets/playOnline/player_left_dialog.dart';
import 'package:tic_tac_toe/widgets/playOnline/welcome_widget.dart';

class PlayOnlineScreen extends StatefulWidget {
  const PlayOnlineScreen({Key? key}) : super(key: key);

  @override
  State<PlayOnlineScreen> createState() => _PlayOnlineScreenState();
}

class _PlayOnlineScreenState extends State<PlayOnlineScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController roomTextController = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => PlayOnlineProvider(context: context),
      child: Consumer<PlayOnlineProvider>(builder: (_, value, __) {
        if (value.showModelScreen && !value.modelScreenAlreadyShown) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => OnlinePlayModalWidget(
                resetGame: value.resetGame,
                returnFunction: value.returnFunction,
                winner: value.winner,
                winnerText:
                    value.didIWIn ? "You Won!" : "${value.opponentName} Wins!",
                provider: value,
              ),
            );
            value.changeModelToTrue();
          });
        }
        if (value.showPlayerLeftDialog) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
                context: context,
                builder: (context) => PlayerLeftDialog(
                      waitForPlayer: value.waitForPlayer,
                    ));
          });
        }
        String announcementText = "";
        if (value.opponentLeft) {
          announcementText =
              "Waiting for Opponent to connect again.. Room Id : ${value.room}";
        } else if (value.waitingForPlayer) {
          announcementText =
              "Waiting for ${value.opponentName} to accept play again.";
        } else {
          announcementText =
              "Hey, ${value.myName}. Please ask your friend to enter Game ID: ${value.room}. Waiting for player 2...";
        }
        return Scaffold(
            appBar: AppBar(
                title: const CenterAppIcon(),
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: value.exitPage)),
            // bottomNavigationBar: BottomNavigationBar(items: const [
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.games_outlined), label: "Game"),
            //   BottomNavigationBarItem(
            //       icon: Icon(Icons.chat_bubble), label: "Chat"),
            // ]),
            body: SingleChildScrollView(
              child: SizedBox(
                  child: (!value.showGameScreen)
                      ? OnlinePlayWelcomeWidget(
                          roomTextController: roomTextController)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              const SizedBox(height: 50),
                              if (value.showRoomAnouncement)
                                BlackCenterButton(textInside: announcementText)
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
                                xCustomName: value.iAmPlayer1 ? "You" : "Oppo",
                                oCustomName: value.iAmPlayer1 ? "Oppo" : "You",
                                // onlyName: true,
                              ),
                            ])),
            ));
      }),
    );
  }
}
