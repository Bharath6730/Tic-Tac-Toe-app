import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';
import 'package:tic_tac_toe/widgets/buttons/center_button.dart';

class BlackCenterButton extends StatelessWidget {
  final String textInside;
  const BlackCenterButton({Key? key, required this.textInside})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: CenterButton(
        contentText: textInside,
        color: AppTheme.silverButtonColor,
        shadowColor: AppTheme.darkShadow,
        backgroundColor: AppTheme.dialogColor,
        radius: 10,
      ),
    );
  }
}
