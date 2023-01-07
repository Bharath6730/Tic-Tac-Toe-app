import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';
import 'package:tic_tac_toe/utilities/constants.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/profile_img.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/playOnline/black_center_button.dart';
import 'package:tic_tac_toe/widgets/playOnline/player_bar.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayOnlineProvider provider = Provider.of<PlayOnlineProvider>(context);

    String announcementText(GameState gameState) {
      if (gameState == GameState.waitingForPlayerToJoin) {
        return "Hey, ${provider.myDetails.name}. Please ask your friend to enter Game ID: ${provider.room}. Waiting for player 2...";
      } else if (gameState == GameState.waitingForPlayerToJoinAgain) {
        return "Waiting for Opponent to connect again.. Room Id : ${provider.room}";
      } else if (gameState == GameState.waitingForNextRoundAcceptance) {
        return "Waiting for ${provider.opponentDetails.name} to accept play again.";
      }
      return "";
    }

    double height = MediaQuery.of(context).size.height;
    double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 70;
    double bottomNavHeight = kBottomNavigationBarHeight;

    return PopWithDialog(
      content: provider.gameState == GameState.playing
          ? "This action declares the opponent as winner."
          : "Do you really want to quit?",
      quitTitle: "Quit",
      quitFunction: provider.quitGame,
      child: Container(
        alignment: Alignment.center,
        height: height - appBarHeight - bottomNavHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showRoomAnouncement(provider.gameState))
                  BlackCenterButton(
                      textInside: announcementText(provider.gameState))
                else
                  BlackCenterButton(
                    textInside:
                        (provider.myTurn) ? "Your TURN" : "Opponent's TURN",
                  ),
                SizedBox(
                  height: min(height * 0.1, 20),
                ),
                PlayerBar(
                  playerName: provider.opponentDetails.name,
                  image: ProfileImage(
                      height: 30,
                      width: 30,
                      imageProvider: getOpponentImage(
                          imageUrl: provider.opponentDetails.profilePic)),
                  score: provider.myButtonType != ButtonType.X
                      ? provider.xWinCount
                      : provider.oWinCount,
                ),
                GameGrid(
                  xoList: provider,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                ),
                PlayerBar(
                  playerName: provider.myDetails.name,
                  image: const ProfileImage(height: 30, width: 30),
                  score: provider.myButtonType == ButtonType.X
                      ? provider.xWinCount
                      : provider.oWinCount,
                ),
              ]),
        ),
      ),
    );
  }
}

ImageProvider<Object> getOpponentImage({required imageUrl}) {
  if (imageUrl == defaultImageUrl) {
    return const AssetImage("assets/images/default-profile-pic.jpg");
  }
  return NetworkImage(imageUrl);
}

bool showRoomAnouncement(GameState gameState) {
  if (gameState == GameState.waitingForNextRoundAcceptance ||
      gameState == GameState.waitingForPlayerToJoin ||
      gameState == GameState.waitingForPlayerToJoinAgain) return true;
  return false;
}
