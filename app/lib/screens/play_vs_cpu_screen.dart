import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/providers/play_vs_cpu_provider.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/dialogs/restart_dialog.dart';
import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_footer.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_grid.dart';
import 'package:tic_tac_toe/widgets/main_widgets/game_header.dart';
import 'package:tic_tac_toe/widgets/dialogs/model_widget.dart';

class PlayVsCPUScreen extends StatelessWidget {
  const PlayVsCPUScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Player selectedPlayer =
        ModalRoute.of(context)?.settings.arguments as Player;
    final GlobalProvider storageProvider =
        Provider.of<GlobalProvider>(context, listen: false);

    return PopWithDialog(
      child: ChangeNotifierProvider(
        create: (context) => PlayVsCPUProvider(
          player: selectedPlayer,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const CenterAppIcon(),
            centerTitle: true,
          ),
          body: Consumer<PlayVsCPUProvider>(
            builder: (_, value, __) {
              if (value.showWinnerDialog) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showAnimatedDialog(
                    context: context,
                    dialog: WinnerDialog(
                      resetGame: value.resetGame,
                      winner: value.winner,
                      winnerText: value.didIWin ? "You Won!" : "CPU Wins!",
                      returnFunction: () {
                        Navigator.of(context).pop("cancel");
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  );
                });
              }
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      GameHeader(
                          currentPlayer: (value.myTurn) ? "Your" : "CPU's",
                          onRefreshClick: () => showAnimatedDialog(
                                context: context,
                                dialog: restartDialog(
                                    context: context,
                                    restartFunction: value.completeReset),
                              )),
                      GameGrid(xoList: value),
                      const SizedBox(height: 20),
                      GameFooter(
                        xWinCount: value.xWinCount,
                        oWinCount: value.oWinCount,
                        tiesCount: value.tiesCount,
                        xCustomName: selectedPlayer == Player.X ? "You" : "CPU",
                        oCustomName: selectedPlayer == Player.X ? "CPU" : "You",
                      ),
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
