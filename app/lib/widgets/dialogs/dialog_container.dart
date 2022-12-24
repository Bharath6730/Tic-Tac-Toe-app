import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  final Widget? child;
  final Widget header;
  final Widget body;
  final Widget footer;
  const DialogContainer({
    Key? key,
    this.child,
    required this.header,
    required this.body,
    required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).appBarTheme.backgroundColor),
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: (child != null)
              ? child as Widget
              : Column(mainAxisSize: MainAxisSize.min, children: [
                  header,
                  const SizedBox(
                    height: 25,
                  ),
                  body,
                  const SizedBox(
                    height: 25,
                  ),
                  footer,
                  const SizedBox(
                    height: 25,
                  ),
                ]),
        ));
  }
}
