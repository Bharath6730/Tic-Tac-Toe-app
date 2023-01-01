import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tic_tac_toe/providers/global_provider.dart';
import 'package:tic_tac_toe/services/socket_service.dart';
import 'package:tic_tac_toe/utilities/profile_img_decoration.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/home_page.dart';
import 'package:tic_tac_toe/widgets/home_screen_widgets/side_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>{
  //   with AutomaticKeepAliveClientMixin {
  // final SocketService socketService = SocketService();
  // late final StreamSubscription _connectionStream;

  // @override
  // bool get wantKeepAlive => true;

  // @override
  // void initState() {
  //   super.initState();
  //   _connectionStream =
  //       socketService.connectionOnChangeStream.listen((bool value) {
  //     print("Connection status : $value");
  //   });
  // }

  // @override
  // void dispose() {
  //   _connectionStream.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);

    String myName = globalProvider.userData!.name;
    String token = globalProvider.userData!.token;
    print("TOken : $token");
    final SocketService socketService = SocketService();
    socketService.init(token);

    return Scaffold(
        drawer: const SideDrawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                width: 40,
                decoration: profileImageDecoration(),
              ),
            )
          ],
        ),
        body: const HomePage());
  }
}
