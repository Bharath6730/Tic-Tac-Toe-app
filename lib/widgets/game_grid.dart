import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/models/xo_button_class.dart';
import './xo_button.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  @override
  Widget build(BuildContext context) {
    List<XOButtonProvider> xOList =
        Provider.of<GameProvider>(context, listen: false).getData();
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height * 0.7,
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: ((context, index) {
            // Use consumer
            return XOButton(
              id: xOList[index].id,
            );
          }),
          itemCount: 9),
    );
  }
}

// Also Looks Nice
// padding: const EdgeInsets.all(25),
// childAspectRatio: 2 / 2.5,
// mainAxisSpacing: 30,
// crossAxisSpacing: 30,