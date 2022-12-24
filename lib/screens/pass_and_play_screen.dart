import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/providers/pass_and_play_provider.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/dialogs/model_widget.dart';
import 'package:tic_tac_toe/widgets/dialogs/pop_with_dialog.dart';
import 'package:tic_tac_toe/widgets/dialogs/restart_dialog.dart';

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
    final LocalStorageProvider storageProvider =
        Provider.of<LocalStorageProvider>(context, listen: false);
    return PopWithDialog(
        child: ChangeNotifierProvider(
      create: (context) =>
          PassAndPlayProvider(playerType: player, storage: storageProvider),
      child: Scaffold(
        appBar: AppBar(
          title: const CenterAppIcon(),
          centerTitle: true,
        ),
        body: Consumer<PassAndPlayProvider>(
          builder: (_, value, __) {
            if (value.showWinnerDialog) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showAnimatedDialog(
                    context: context,
                    dialog: WinnerDialog(
                      resetGame: value.resetGame,
                      returnFunction: () {
                        Navigator.of(context).pop("cancel");
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      winner: value.winner as ButtonType,
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
                    GameHeader(
                      currentPlayer: currentPlayerString,
                      onRefreshClick: () => showAnimatedDialog(
                        context: context,
                        dialog: restartDialog(
                            context: context,
                            restartFunction: value.completeReset),
                      ),
                    ),
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
    ));
  }
}
