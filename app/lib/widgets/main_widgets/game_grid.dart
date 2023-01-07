import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/models/logic_provider.dart';
import 'package:tic_tac_toe/models/xo_button_class.dart';

import '../buttons/xo_button.dart';

class GameGrid extends StatelessWidget {
  final LogicProvider xoList;
  final EdgeInsets? padding;
  const GameGrid({Key? key, required this.xoList, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 200,
        maxHeight: 420,
        maxWidth: 420,
      ),
      child: GridView.builder(
          // Required for keeping gridview
          shrinkWrap: true,
          primary: false,
          //
          padding: padding ?? const EdgeInsets.all(30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
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
          itemCount: 9),
    );
  }
}
