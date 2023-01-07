import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/services/socket_service.dart';
import 'package:tic_tac_toe/utilities/navbar_animated_body.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/bottom_nav_bar.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/home_page.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedOption = 0;

  void changeBody(value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);

    String token = globalProvider.userData!.token;
    final SocketService socketService = SocketService();
    socketService.init(token);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Icon(
                Icons.notifications_outlined,
                size: 20,
              ))
        ],
      ),
      drawer: const SideDrawer(),
      bottomNavigationBar: BottomNavBar(
        selectedOption: selectedOption,
        onTap: changeBody,
      ),
      body: GetAnimatedBody(
        child: getBody(selectedOption),
      ),
    );
  }
}

Widget getBody(value) {
  switch (value) {
    case 0:
      return const HomePage();
    case 1:
      return const Center(
          child: Text(
        "Friends Page",
        style: TextStyle(color: Colors.white54),
      ));
    case 2:
      return const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white54),
        ),
      );
    default:
      return const HomePage();
  }
}
