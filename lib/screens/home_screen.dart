import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

import 'package:tic_tac_toe/widgets/buttons/submit_button.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:tic_tac_toe/widgets/main_widgets/center_app_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // void connect() {
  //   print("Running");
  //   // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
  //   IO.Socket socket =
  //       IO.io("https://bharath6730.herokuapp.com/", <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("messageFromServer", (msg) {
  //       // final msgString = json.decode(msg.toString());
  //       print(msg);
  //     });
  //     socket.emit("messageToServer", "Bro what the fuck it works");
  //   });
  //   print(socket.connected);
  // }

  @override
  Widget build(BuildContext context) {
    // connect();
    return Scaffold(
      drawer: const Drawer(),
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      //   title: const CenterAppIcon(),
      //   centerTitle: true,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: Container(
      //         width: 40,
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           image: DecorationImage(
      //             fit: BoxFit.cover,
      //             image: NetworkImage(
      //               "https://www.clipartkey.com/mpngs/m/152-1520367_user-profile-default-image-png-clipart-png-download.png",
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SubmitButton(
            color: Colors.black,
            shadowColor: AppTheme.oShadowColor,
            backgroundColor: AppTheme.oButtonColor,
            splashColor: AppTheme.oHoverColor,
            radius: 15,
            onPressed: () {
              Navigator.pushNamed(context, "/passAndPlay");
            },
            child: Text(
              "Pass and Play",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SubmitButton(
            color: Colors.black,
            shadowColor: AppTheme.oShadowColor,
            backgroundColor: AppTheme.oButtonColor,
            splashColor: AppTheme.oHoverColor,
            radius: 15,
            onPressed: () {
              Navigator.pushNamed(context, "/playVsCPU");
            },
            child: Text(
              "Play Vs Computer",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SubmitButton(
            color: Colors.black,
            shadowColor: AppTheme.oShadowColor,
            backgroundColor: AppTheme.oButtonColor,
            splashColor: AppTheme.oHoverColor,
            radius: 15,
            onPressed: () {
              Navigator.pushNamed(context, "/passAndPlay");
            },
            child: Text(
              "Play Online",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
    );
  }
}
