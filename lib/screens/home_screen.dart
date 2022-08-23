import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        // title: ,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              child: Image.network(
                  "https://res.cloudinary.com/dciwowqk7/image/upload/v1660972836/user/e6crkzsjbcy0gkzah0ul.png"),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Hello"),
      ),
    );
  }
}
