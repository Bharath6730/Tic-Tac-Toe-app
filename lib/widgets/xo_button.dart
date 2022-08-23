import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:tic_tac_toe/providers/game_provider.dart';
import 'package:tic_tac_toe/providers/xo_button_provider.dart';
// import 'package:tic_tac_toe/providers/xo_button_provider.dart';
// import 'package:flutter_svg/avd.dart';

class XOButton extends StatelessWidget {
  final VoidCallback buttonClick;
  final int id;
  final GameOptions buttonType;
  const XOButton(
      {Key? key,
      required this.id,
      required this.buttonClick,
      required this.buttonType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadowColor = Theme.of(context).appBarTheme.shadowColor as Color;

    // GameProvider buttonData = Provider.of<GameProvider>(context);

    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            // color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 2,
                spreadRadius: 2,
              )
            ]),
        alignment: Alignment.center,
        child: Stack(
          children: [
            if (buttonType != GameOptions.none)
              Positioned(
                left: 25,
                top: 25,
                child: SvgPicture.asset((buttonType == GameOptions.X)
                    ? "assets/images/x_filled.svg"
                    : "assets/images/o_filled.svg"),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: buttonClick,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

// Stack(children: [
//           InkWell(
//             borderRadius: BorderRadius.circular(15),
//             splashColor: Colors.blue,
//             onTap: buttonClick,
//             child: SizedBox(
//               width: double.infinity,
//               height: double.infinity,
//             ),
//           ),
//           Positioned(
//             left: 25,
//             top: 25,
//             child: SvgPicture.asset(assetLnk
//                 // color: Colors.red,
//                 ),
//           ),
//         ])

// Works
// InkWell(
//           borderRadius: BorderRadius.circular(15),
//           splashColor: Colors.amber,
//           onTap: buttonClick,
//           child: Ink(
//             child: Center(child: SvgPicture.asset(assetLnk)),
//           ),
//         )