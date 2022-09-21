import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tic_tac_toe/utilities/online_play_classes.dart';
import 'package:tic_tac_toe/utilities/utlility.dart';

import './../models/logic_provider.dart';

class PlayOnlineProvider extends LogicProvider with ChangeNotifier {
  // io.Socket socket =
  //     io.io("https://bharath6730.herokuapp.com/", <String, dynamic>{
  //   "transports": ["websocket"],
  //   "autoConnect": false,
  // });
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
  bool iAmPlayer1 = true;
  Player myButtonType = Player.X;
  bool showRoomAnouncement = true;
  bool didIWIn = false;
  bool didIStartFirst = false;

  bool showPlayerLeftDialog = false;
  bool myTurnCopy = false;
  bool opponentLeft = false;
  bool waitingForPlayer = false;
  bool opponentWantsToPlayAgain = false;
  bool modelScreenAlreadyShown = false;

  PlayOnlineProvider({required this.context}) {
    if (!connected) initializeSocket(context);
  }

  // Set iamPlayer1 to false if joining game
  void change() {
    opponentWantsToPlayAgain = false;
    notifyListeners();
  }

  void initializeSocket(context) {
    if (!socket.connected) {
      socket.connect();
    }

    // socket.onError((data) {
    // });

    // socket.onConnectTimeout((data) {

    // });
    // socket.onerror((data) => print(data));
    socket.onConnectError((data) {
      showSnackBar("There was error .Please try again later.");
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
      if (!opponentLeft) {
        GameMessage gameMessage = GameMessage.fromJson(data);
        opponentName = gameMessage.player2 as String;
        showRoomAnouncement = false;
        iAmPlayer1 = true;
        myTurn = true;

        socket.emit("p1Detail",
            {"player1": myName, "player2": opponentName, "room": room});

        notifyListeners();
      } else {
        // Reconnect player

        myTurn = myTurnCopy;
        showRoomAnouncement = false;
        showPlayerLeftDialog = false;
        opponentLeft = false;

        List<String> xList = xButtons.map((e) => "0${e.toString()}").toList();
        List<String> oList = oButtons.map((e) => "0${e.toString()}").toList();

        socket.emit("playerAlreadyLeft", {
          "xList": xList,
          "oList": oList,
          "myScore": xWinCount,
          "TotalGames": xWinCount + tiesCount + oWinCount,
          "draw": tiesCount,
          "oppName": opponentName,
          "Player": (myButtonType == Player.X) ? "X" : "O",
          "myTurn": myTurn,
          "player1": myName,
          "room": room,
        });
      }
      notifyListeners();
    });

    socket.on("details", (data) {
      if (!data.toString().contains("TotalGames")) {
        GameMessage gameMessage = GameMessage.fromJson(data);
        room = gameMessage.room;
        myButtonType = Player.O;
        playerType = Player.O;
        opponentName = gameMessage.player1 as String;

        myTurn = false;
        iAmPlayer1 = false;
        showGameScreen = true;
        showRoomAnouncement = false;
      } else {
        ReJoin rejoinMessage = ReJoin.fromJson(data);

        opponentName = rejoinMessage.player1 as String;
        room = rejoinMessage.room;
        playerType = Player.X;
        for (var element in rejoinMessage.xList!) {
          element = int.parse(element);
          super.onButtonClick(element);
        }

        playerType = Player.O;
        for (var element in rejoinMessage.oList!) {
          element = int.parse(element);
          super.onButtonClick(element);
        }

        if (rejoinMessage.player == Player.X) {
          xWinCount = rejoinMessage.myScore;
          tiesCount = rejoinMessage.draw;
          oWinCount = rejoinMessage.totalGames - tiesCount - xWinCount;
          myButtonType = Player.O;
          iAmPlayer1 = false;
        } else {
          tiesCount = rejoinMessage.draw;
          oWinCount = rejoinMessage.myScore;
          xWinCount = rejoinMessage.totalGames - tiesCount - oWinCount;
          myButtonType = Player.X;
          iAmPlayer1 = true;
        }
        myTurn = !rejoinMessage.myTurn;
        showGameScreen = true;
        showRoomAnouncement = false;
      }
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
        // modelScreenAlreadyShown = true;
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

    socket.on("playerLeft", (_) {
      // print(data);
      // showRoomAnouncement = true;
      showModelScreen = false;
      showPlayerLeftDialog = true;
      myTurnCopy = myTurn;
      myTurn = false;
      opponentLeft = true;

      notifyListeners();
    });
    socket.on("next-round", (_) {
      if (waitingForPlayer) {
        playerType = myButtonType;
        if (didIStartFirst) {
          myTurn = false;
        } else {
          myTurn = true;
        }
        waitingForPlayer = false;
        showRoomAnouncement = false;
        opponentWantsToPlayAgain = false;
      } else {
        opponentWantsToPlayAgain = true;
        // showSnackBar("$opponentName wants to play again.");
      }
      notifyListeners();
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

  void waitForPlayer() {
    showPlayerLeftDialog = false;
    showRoomAnouncement = true;

    notifyListeners();
  }

  void changeModelToTrue() {
    modelScreenAlreadyShown = true;
  }

  void changeModelToFalse() {
    modelScreenAlreadyShown = false;
  }

  void returnFunction() {
    Navigator.of(context).pop();
    changeModelToFalse();
  }

  void exitPage() {
    if (showGameScreen) {
      showGameScreen = false;
      notifyListeners();
      return;
    }
    disconnectSocket();
    Navigator.of(context).pop();
  }

  @override
  bool onButtonClick(int id) {
    bool isChanged = false;
    if (!myTurn) return isChanged;
    isChanged = super.onButtonClick(id);

    if (!isChanged) return isChanged;

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
    if (!opponentWantsToPlayAgain) {
      myTurn = false;
      showRoomAnouncement = true;
      waitingForPlayer = true;
    } else {
      // showModelScreen = false;
      opponentWantsToPlayAgain = false;
      playerType = myButtonType;
      if (didIStartFirst) {
        myTurn = false;
      } else {
        myTurn = true;
      }
    }
    socket.emit("next-round", {"room": room});
    changeModelToFalse();

    notifyListeners();
  }
}
