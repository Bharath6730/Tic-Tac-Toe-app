import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
// import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_header.dart';
import 'package:tic_tac_toe/widgets/model_widget.dart';

class PlayOnlineScreen extends StatelessWidget {
  const PlayOnlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController roomTextController = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => PlayOnlineProvider(context: context),
      child: Consumer<PlayOnlineProvider>(builder: (_, value, __) {
        // String currentPlayerString = ;
        // print(currentPlayerString);
        if (value.showModelScreen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => ModelWidget(
                resetGame: value.resetGame,
                winner: value.winner,
                winnerText:
                    value.didIWIn ? "You Won!" : "${value.opponentName} Wins!",
              ),
            );
          });
        }
        if (value.showPlayerLeftDialog) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                Theme.of(context).appBarTheme.backgroundColor),
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        child: Column(children: [
                          const Text(
                            "Opponent Left the Game",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Text(
                              "You can either wait for the player to join again or return to main page.",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SubmitButton(
                                backgroundColor: AppTheme.silverButtonColor,
                                shadowColor: AppTheme.silverShadowColor,
                                splashColor: AppTheme.silverHoverColor,
                                radius: 15,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (Navigator.canPop(context)) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  "Return",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SubmitButton(
                                backgroundColor: AppTheme.oButtonColor,
                                shadowColor: AppTheme.oShadowColor,
                                splashColor: AppTheme.oHoverColor,
                                radius: 15,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  value.waitForPlayer();
                                },
                                child: Text(
                                  "Wait for Player",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ));
          });
        }
        return Scaffold(
            appBar: AppBar(
                title: const CenterAppIcon(),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    value.disconnectSocket();
                    Navigator.pop(context, false);
                  },
                )),
            body: SingleChildScrollView(
              child: SizedBox(
                  child: (!value.showGameScreen)
                      ? Column(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          CenterContainer(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                    child: Text("Create Game",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.white))),
                                Text(
                                  "Create game and get room code ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                SubmitButton(
                                  shadowColor: AppTheme.silverShadowColor,
                                  backgroundColor: AppTheme.silverButtonColor,
                                  splashColor: AppTheme.silverHoverColor,
                                  onPressed: value.createGame,
                                  radius: 15,
                                  child: Text("Get Room Code",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                )
                              ],
                            ),
                          ),
                          CenterContainer(
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                    child: Text("Join Game",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.white))),
                                Text(
                                  "Join Game with a room Code ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: TextField(
                                    controller: roomTextController,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        hintText: "Enter room code",
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme
                                                    .silverButtonColor)),
                                        focusColor: AppTheme.oButtonColor,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme
                                                    .silverButtonColor))),
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (roomName) =>
                                        value.joinGame(roomName),
                                  ),
                                ),
                                SubmitButton(
                                  shadowColor: AppTheme.silverShadowColor,
                                  backgroundColor: AppTheme.silverButtonColor,
                                  splashColor: AppTheme.silverHoverColor,
                                  onPressed: () {
                                    if (roomTextController.text.isNotEmpty) {
                                      value.joinGame(roomTextController.text);
                                    }
                                  },
                                  radius: 15,
                                  child: Text("Join Game",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                )
                              ],
                            ),
                          ),
                        ])
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              const SizedBox(height: 50),
                              if (value.showRoomAnouncement)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  child: CenterButton(
                                    contentText: (value.opponentLeft)
                                        ? "Waiting for Opponent to connect again.. Room Id : ${value.room}"
                                        : "Hey, ${value.myName}. Please ask your friend to enter Game ID: ${value.room}. Waiting for player 2...",
                                    color: AppTheme.silverButtonColor,
                                    shadowColor: AppTheme.darkShadow,
                                    backgroundColor: AppTheme.dialogColor,
                                    splashColor: AppTheme.darkShadow,
                                    onPressed: () {},
                                    radius: 10,
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: GameHeader(
                                    currentPlayer:
                                        (value.myTurn) ? "Your" : "Opponent's",
                                  ),
                                ),
                              GameGrid(xoList: value),
                              const SizedBox(height: 25),
                              GameFooter(
                                xWinCount: value.xWinCount,
                                oWinCount: value.oWinCount,
                                tiesCount: value.tiesCount,
                                xCustomName: value.myName,
                                oCustomName: value.opponentName,
                              ),
                            ])),
            ));
      }),
    );
  }
}

class CenterContainer extends StatelessWidget {
  final Widget child;
  final double height;
  const CenterContainer({Key? key, required this.child, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).appBarTheme.backgroundColor),
        child: child);
  }
}
