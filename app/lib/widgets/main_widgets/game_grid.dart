import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/logic_provider.dart';
import 'package:tic_tac_toe/models/xo_button_class.dart';

import '../buttons/xo_button.dart';

class GameGrid extends StatelessWidget {
  final LogicProvider xoList;
  const GameGrid({Key? key, required this.xoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // Required for keeping gridview
        shrinkWrap: true,
        primary: false,
        //
        padding: const EdgeInsets.all(30),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: ((context, index) {
          return ChangeNotifierProvider<XOButtonProvider>.value(
            value: xoList.getData()[index],
            child: XOButton(
              id: index + 1,
              onButtonClick: xoList.onButtonClick,
            ),
          );
        }),
        itemCount: 9);
  }
}

// Also Looks Nice
// padding: const EdgeInsets.all(25),
// childAspectRatio: 2 / 2.5,
// mainAxisSpacing: 30,
// crossAxisSpacing: 30,

// 
// padding: const EdgeInsets.all(15),
// childAspectRatio: 1,
// mainAxisSpacing: 10,
// crossAxisSpacing: 10,