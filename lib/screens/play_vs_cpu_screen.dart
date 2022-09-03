import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/play_vs_cpu_provider.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_header.dart';
import 'package:tic_tac_toe/widgets/model_widget.dart';

class PlayVsCPUScreen extends StatelessWidget {
  const PlayVsCPUScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayVsCPUProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const CenterAppIcon(),
          centerTitle: true,
        ),
        body: Consumer<PlayVsCPUProvider>(
          builder: (_, value, __) {
            if (value.showModelScreen) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => ModelWidget(
                    resetGame: value.resetGame,
                    winner: value.winner,
                    winnerText: value.didIWin ? "You Won!" : "CPU Wins!",
                    // whoWon: "CPU Wins!",
                  ),
                );
              });
            }
            // String currentPlayerString = (value.myTurn) ? "Your" : "CPU's";
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  GameHeader(
                    currentPlayer: (value.myTurn) ? "Your" : "Opponent's",
                  ),
                  GameGrid(xoList: value),
                  const SizedBox(height: 20),
                  GameFooter(
                    xWinCount: value.xWinCount,
                    oWinCount: value.oWinCount,
                    tiesCount: value.tiesCount,
                    xCustomName: "You",
                    oCustomName: "CPU",
                  ),
                ]);
          },
        ),
      ),
    );
  }
}
