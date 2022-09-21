import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/pass_and_play_provider.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/model_widget.dart';

import '../widgets/main_widgets/center_app_icon.dart';
import '../widgets/main_widgets/game_header.dart';
import '../widgets/main_widgets/game_grid.dart';
import '../widgets/main_widgets/game_footer.dart';

class PassAndPlayScreen extends StatelessWidget {
  const PassAndPlayScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context)?.settings.arguments as Player;

    return ChangeNotifierProvider(
      create: (context) => PassAndPlayProvider(playerType: player),
      child: Scaffold(
        appBar: AppBar(
          title: const CenterAppIcon(),
          centerTitle: true,
        ),
        body: Consumer<PassAndPlayProvider>(
          builder: (_, value, __) {
            if (value.showModelScreen) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    context: context,
                    builder: (context) => ModelWidget(
                          resetGame: value.resetGame,
                          returnFunction: () {
                            Navigator.of(context).pop();
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          winner: value.winner,
                          winnerText: "You Won!",
                        ));
              });
            }
            String currentPlayerString =
                (value.playerType == Player.X) ? "X" : "O";
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    GameHeader(currentPlayer: currentPlayerString),
                    GameGrid(xoList: value),
                    const SizedBox(height: 20),
                    GameFooter(
                      oWinCount: value.oWinCount,
                      xWinCount: value.xWinCount,
                      tiesCount: value.tiesCount,
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
