import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tic_tac_toe/utilities/utlility.dart';

import './../models/logic_provider.dart';

class Message {
  final String data;

  Message({required this.data});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(data: json['data']);
  }
}

class WinnerMessage {
  int? X;
  int? Y;
  String winner;
  List<dynamic>? winnerWho;
  Player? whoStarted;

  WinnerMessage(
      {required this.winner,
      required this.winnerWho,
      this.X,
      this.Y,
      this.whoStarted}) {
    winnerWho ??= winnerWho?.map((e) => int.tryParse(e[1])).toList();
  }

  factory WinnerMessage.fromJson(Map<String, dynamic> json) {
    return WinnerMessage(
        winner: json["winner"],
        winnerWho: json["who"],
        X: int.tryParse(json["X"].toString()[1]),
        Y: int.tryParse(json["Y"].toString()[1]),
        whoStarted: (json["whoStarted"] == "X") ? Player.X : Player.O);
  }
}

class GameMessage {
  final String room;
  List<dynamic>? oList;
  List<dynamic>? xList;
  String? player1;
  String? player2;
  int? X;
  int? Y;

  GameMessage(
      {this.oList,
      required this.room,
      this.xList,
      this.player1,
      this.player2,
      this.X,
      this.Y}) {
    oList ??= oList?.map((e) => int.tryParse(e[1])).toList() ?? [];
    xList ??= xList?.map((e) => int.tryParse(e[1])).toList() ?? [];
  }
  factory GameMessage.fromJson(Map<String, dynamic> json) {
    // print(json);
    return GameMessage(
        room: json["room"],
        player2: json["player2"],
        oList: json["oList"],
        xList: json["xList"],
        player1: json["player1"],
        X: int.tryParse(json["X"].toString()[1]),
        Y: int.tryParse(json["Y"].toString()[1]));
  }
}

class PlayOnlineProvider extends LogicProvider with ChangeNotifier {
  io.Socket socket = io.io("http://172.20.139.185:3000/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });

  BuildContext context;
  final String myName = "Bharath";
  String opponentName = "Opponent";

  String? room;
  bool connected = false;
  bool showGameScreen = false;
  bool iAmPlayer1 = false;
  Player myButtonType = Player.X;
  bool showRoomAnouncement = true;
  bool didIWIn = false;
  bool didIStartFirst = false;

  PlayOnlineProvider({required this.context}) {
    if (!connected) initializeSocket(context);
  }

  // Set iamPlayer1 to false if joining game

  void initializeSocket(context) {
    socket.connect();

    socket.onError((data) {
      print(data);
      print("1");
    });

    socket.onConnectTimeout((data) {
      print(data);
      print("3");
    });
    socket.onerror((data) => print(data));
    socket.onConnectError((data) {
      print(data);
      showSnackBar("There was error .Please try again later.");
    });

    socket.onPing((data) {
      print(data);
    });
    socket.onPong((data) {
      print(data);
    });

    socket.onConnect((data) {
      socket.on("messageFromServer", (msg) {
        Message string = Message.fromJson(msg);
        showSnackBar(string.data);
      });

      socket.onDisconnect(((data) {
        showSnackBar("Disconnected from server");
      }));

      socket.emit("messageToServer", "Successfully connected.");
    });

    socket.on("gameCreated", (data) {
      GameMessage gameMessage = GameMessage.fromJson(data);
      showGameScreen = true;
      myTurn = false;
      room = gameMessage.room;
      notifyListeners();
    });

    socket.on("arrange", (data) {
      GameMessage gameMessage = GameMessage.fromJson(data);
      opponentName = gameMessage.player2 as String;
      showRoomAnouncement = false;
      iAmPlayer1 = true;
      myTurn = true;

      socket.emit("p1Detail",
          {"player1": myName, "player2": opponentName, "room": room});

      notifyListeners();
    });

    socket.on("details", (data) {
      GameMessage gameMessage = GameMessage.fromJson(data);
      room = gameMessage.room;
      myButtonType = Player.O;
      playerType = Player.O;
      opponentName = gameMessage.player1 as String;

      myTurn = false;
      iAmPlayer1 = false;
      showGameScreen = true;
      showRoomAnouncement = false;

      notifyListeners();
    });

    socket.on("game", (data) {
      GameMessage gameMessage = GameMessage.fromJson(data);
      togglePlayer();

      int id;
      if (myButtonType == Player.X) {
        id = gameMessage.Y as int;
      } else {
        id = gameMessage.X as int;
      }
      super.onButtonClick(id);

      togglePlayer();
      myTurn = true;

      notifyListeners();
    });

    socket.on("winner", (data) {
      WinnerMessage gameMessage = WinnerMessage.fromJson(data);
      // print("Who started First : ${gameMessage.whoStarted}");
      if (myButtonType == gameMessage.whoStarted) {
        didIStartFirst = true;
      } else {
        didIStartFirst = false;
      }
      if (gameMessage.winner == "X") {
        playerType = Player.X;
        if (myButtonType != Player.X) {
          super.onButtonClick(gameMessage.X as int);
          didIWIn = false;
        } else {
          didIWIn = true;
        }
      } else if (gameMessage.winner == "O") {
        playerType = Player.O;
        if (myButtonType != Player.O) {
          super.onButtonClick(gameMessage.Y as int);
          didIWIn = false;
        } else {
          didIWIn = true;
        }
      } else {
        if (gameMessage.X != null) {
          playerType = Player.X;
          super.onButtonClick(gameMessage.X as int);
        } else {
          playerType = Player.O;
          super.onButtonClick(gameMessage.Y as int);
        }
      }

      bool winners = super.checkWinner();

      if (winners) {
        myTurn = false;
        showModelScreen = true;
        playerType = myButtonType;
      }
      notifyListeners();
    });

    socket.on("roomFull", (data) {
      Message message = Message.fromJson(data);
      showSnackBar(message.data);
    });
    socket.on("wrongRoom", (data) {
      Message message = Message.fromJson(data);
      showSnackBar(message.data);
    });

    connected = socket.connected;
  }

  void disconnectSocket() {
    socket.disconnect();
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      text,
      textAlign: TextAlign.center,
    )));
  }

  void createGame() {
    socket.emit("createGame", {"name": "Bharath"});
  }

  void joinGame(String roomName) {
    socket.emit("joinGame", {"player2": myName, "room": roomName});
  }

  @override
  bool onButtonClick(int id) {
    bool isChanged = false;
    if (!myTurn) return isChanged;

    isChanged = super.onButtonClick(id);

    String myButton = (myButtonType == Player.X) ? "X" : "Y";
    List<String> xList = xButtons.map((e) => "0${e.toString()}").toList();
    List<String> oList = oButtons.map((e) => "0${e.toString()}").toList();
    socket.emit("game",
        {"room": room, myButton: "0$id", "xList": xList, "oList": oList});
    myTurn = false;
    notifyListeners();

    return isChanged;
  }

  @override
  void resetGame() {
    super.resetGame();
    playerType = myButtonType;
    if (didIStartFirst) {
      myTurn = false;
    } else {
      myTurn = true;
    }

    notifyListeners();
  }
}
