import 'package:flutter/material.dart';

class DialogContainer extends StatelessWidget {
  final Widget? child;
  final Widget header;
  final Widget body;
  final Widget footer;
  final List<double>? gap;
  const DialogContainer(
      {Key? key,
      this.child,
      required this.header,
      required this.body,
      required this.footer,
      this.gap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).appBarTheme.backgroundColor),
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: (child != null)
              ? child as Widget
              : Column(mainAxisSize: MainAxisSize.min, children: [
                  header,
                  gap == null
                      ? const SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: gap![0],
                        ),
                  body,
                  gap == null
                      ? const SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: gap![1],
                        ),
                  footer,
                  gap == null
                      ? const SizedBox(
                          height: 25,
                        )
                      : SizedBox(
                          height: gap![2],
                        ),
                ]),
        ));
  }
}
