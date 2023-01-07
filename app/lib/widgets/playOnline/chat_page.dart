import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final Function changePage;
  const ChatPage({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        changePage(0);
        return Future.value(false);
      },
      child: const Center(
        child: Text("Chat Page"),
      ),
    );
  }
}
