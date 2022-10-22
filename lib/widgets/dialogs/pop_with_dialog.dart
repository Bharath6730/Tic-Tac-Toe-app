import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/dialog_animater.dart';
import 'package:tic_tac_toe/widgets/dialogs/custom_dialog.dart';

class PopWithDialog extends StatelessWidget {
  final String? headerTitle;
  final String? content;
  final String? cancelTitle;
  final String? quitTitle;
  final VoidCallback? cancelFunction;
  final VoidCallback? quitFunction;
  final Widget child;

  const PopWithDialog({
    this.headerTitle,
    this.content,
    this.cancelTitle,
    this.quitTitle,
    this.cancelFunction,
    this.quitFunction,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final value = await showAnimatedDialog(
              context: context,
              dialog: CustomDialog(
                  headerTitle: headerTitle != null
                      ? headerTitle as String
                      : "Are you sure?",
                  body: Text(
                    content != null
                        ? content as String
                        : "The game will reset when you leave this screen.",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  leftButtonTitle:
                      cancelTitle != null ? cancelTitle as String : "Cancel",
                  onLeftButtonPress: cancelFunction != null
                      ? cancelFunction as VoidCallback
                      : () {
                          Navigator.of(context).pop("cancel");
                        },
                  rightButtonTitle:
                      quitTitle != null ? quitTitle as String : "Exit",
                  onRightButtonPress: quitFunction != null
                      ? quitFunction as VoidCallback
                      : () {
                          Navigator.of(context).pop("true");
                          Navigator.of(context).pop();
                        }));
          return value;
        },
        child: child);
  }
}
