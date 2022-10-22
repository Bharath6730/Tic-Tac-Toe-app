import 'package:flutter/material.dart';

Future<bool> showAnimatedDialog(
    {required BuildContext context, required Widget dialog}) async {
  final value = await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: Curves.bounceInOut.transform(a1.value),
          child: Opacity(opacity: a1.value, child: widget),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return dialog;
      });
  return value == "true";
}
