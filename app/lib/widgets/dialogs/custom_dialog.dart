import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
import 'package:tic_tac_toe/widgets/dialogs/dialog_container.dart';

class CustomDialog extends StatelessWidget {
  final String headerTitle;
  final TextStyle? headerStyle;
  final Widget body;
  final String leftButtonTitle;
  final VoidCallback onLeftButtonPress;
  final String rightButtonTitle;
  final VoidCallback onRightButtonPress;
  const CustomDialog({
    Key? key,
    required this.headerTitle,
    this.headerStyle,
    required this.body,
    required this.leftButtonTitle,
    required this.onLeftButtonPress,
    required this.rightButtonTitle,
    required this.onRightButtonPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      header: DialogHeader(headerTitle: headerTitle, headerStyle: headerStyle),
      body: body,
      footer: DialogFooter(
          onLeftButtonPress: onLeftButtonPress,
          leftButtonTitle: leftButtonTitle,
          onRightButtonPress: onRightButtonPress,
          rightButtonTitle: rightButtonTitle),
    );
  }
}

class DialogFooter extends StatelessWidget {
  const DialogFooter({
    Key? key,
    required this.onLeftButtonPress,
    required this.leftButtonTitle,
    required this.onRightButtonPress,
    required this.rightButtonTitle,
  }) : super(key: key);

  final VoidCallback onLeftButtonPress;
  final String leftButtonTitle;
  final VoidCallback onRightButtonPress;
  final String rightButtonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SubmitButton(
        boxColor: BoxColor.silver,
        radius: 12,
        onPressed: onLeftButtonPress,
        child: Text(
          leftButtonTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      SubmitButton(
        boxColor: BoxColor.yellow,
        radius: 12,
        onPressed: onRightButtonPress,
        child: Text(
          rightButtonTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    Key? key,
    required this.headerTitle,
    required this.headerStyle,
  }) : super(key: key);

  final String headerTitle;
  final TextStyle? headerStyle;

  @override
  Widget build(BuildContext context) {
    return Text(headerTitle,
        style: headerStyle != null
            ? headerStyle as TextStyle
            : const TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center);
  }
}
