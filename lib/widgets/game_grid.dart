import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/providers/xo_button_provider.dart';
// import 'package:tic_tac_toe/providers/game_logic_provider.dart';
import './xo_button.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  Player _playerType = Player.O;
  bool _myTurn = true;

  List<XOButtonProvider> _xOList = List.generate(9, (index) {
    return XOButtonProvider(id: index, buttontype: GameOptions.none);
  });

  void onButtonClick(int id) {
    XOButtonProvider button = _xOList.firstWhere((element) => element.id == id);
    if (_myTurn == false) return;

    setState(() {
      if (_playerType == Player.X) {
        button.buttontype = GameOptions.X;
      } else {
        button.buttontype = GameOptions.O;
      }
    });

    _myTurn = false;
  }

  @override
  Widget build(BuildContext context) {
    // List<XOButtonProvider> _xOList =
    //     Provider.of<GameProvider>(context, listen: false).getData();
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
              id: _xOList[index].id,
              buttonClick: () => onButtonClick(_xOList[index].id),
              buttonType: _xOList[index].buttontype,
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