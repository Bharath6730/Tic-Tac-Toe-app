import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/widgets/model_widget.dart';

import '../widgets/main_widgets/center_app_icon.dart';
import '../widgets/main_widgets/game_header.dart';
import '../widgets/main_widgets/game_grid.dart';
import '../widgets/main_widgets/game_footer.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CenterAppIcon(),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 80),
        const GameHeader(),
        const GameGrid(),
        const SizedBox(height: 20),
        const GameFooter(),
        Consumer<GameProvider>(builder: ((_, value, __) {
          if (value.showModelScreen) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showGameOverDialog(context, value.resetGame, value.winner);
            });
          }
          return Container();
        }))
      ]),
    );
  }
}
