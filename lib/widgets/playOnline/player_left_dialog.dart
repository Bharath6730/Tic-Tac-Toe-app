import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';

class PlayerLeftDialog extends StatelessWidget {
  final VoidCallback waitForPlayer;
  const PlayerLeftDialog({Key? key, required this.waitForPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).appBarTheme.backgroundColor),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(children: [
          const Text(
            "Opponent Left the Game",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
              "You can either wait for the player to join again or return to main page.",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SubmitButton(
                backgroundColor: AppTheme.silverButtonColor,
                shadowColor: AppTheme.silverShadowColor,
                splashColor: AppTheme.silverHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "Return",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SubmitButton(
                backgroundColor: AppTheme.oButtonColor,
                shadowColor: AppTheme.oShadowColor,
                splashColor: AppTheme.oHoverColor,
                radius: 15,
                onPressed: () {
                  Navigator.of(context).pop();
                  waitForPlayer();
                },
                child: Text(
                  "Wait for Player",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}