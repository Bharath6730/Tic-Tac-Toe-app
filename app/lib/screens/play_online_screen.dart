import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_online_provider.dart';

import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/navbar_animated_body.dart';
import 'package:tic_tac_toe/utilities/svg_nav_icon.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/playOnline/chat_page.dart';
import 'package:tic_tac_toe/widgets/playOnline/dialog_manager.dart';
import 'package:tic_tac_toe/widgets/playOnline/game_page.dart';
import 'package:tic_tac_toe/widgets/playOnline/winner_dialog.dart';

class PlayOnlineScreen extends StatefulWidget {
  const PlayOnlineScreen({Key? key}) : super(key: key);

  @override
  State<PlayOnlineScreen> createState() => _PlayOnlineScreenState();
}

class _PlayOnlineScreenState extends State<PlayOnlineScreen> {
  int selectedOption = 0;
  void changeBody(int value) {
    setState(() {
      selectedOption = value;
    });
  }

  Widget getBody(int selectedOption) {
    if (selectedOption == 0) return const GamePage();
    return ChatPage(
      changePage: changeBody,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayOnlineProvider>.value(
        value: ModalRoute.of(context)?.settings.arguments as PlayOnlineProvider,
        child: Scaffold(
            appBar: AppBar(
              title: const CenterAppIcon(),
              centerTitle: true,
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppTheme.dialogColor,
                currentIndex: selectedOption,
                showUnselectedLabels: false,
                unselectedIconTheme: IconThemeData(
                    color: Colors.grey.withOpacity(0.5), size: 25),
                selectedIconTheme: IconThemeData(
                    color: Colors.white.withOpacity(0.8), size: 25),
                showSelectedLabels: false,
                onTap: (value) => changeBody(value),
                items: [
                  BottomNavigationBarItem(
                      icon: NavBarSvgIcon(
                          iconNumber: 0,
                          selectedOption: selectedOption,
                          asset: "assets/svg/game/game.svg"),
                      label: "Game"),
                  BottomNavigationBarItem(
                      icon: NavBarSvgIcon(
                          iconNumber: 1,
                          selectedOption: selectedOption,
                          asset: "assets/svg/game/chat.svg"),
                      label: "Chat"),
                ]),
            body: Consumer<PlayOnlineProvider>(builder: (_, value, __) {
              if (value.showWinnerDialog && !value.winnerDialogAlreadyShown) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  value.changeModelToTrue();
                  await showAnimatedDialog(
                    context: context,
                    dialog: OnlinePlayWinnerDialog(
                      resetGame: value.resetGame,
                      returnFunction: value.quitGame,
                      winner: value.winner,
                      winnerText: value.amiWinner()
                          ? "You Won!"
                          : "${value.opponentDetails.name} Wins!",
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
              return GetAnimatedBody(
                  // offset: const Offset(0.0, 1.0),
                  child: getBody(selectedOption));
            })));
  }
}
