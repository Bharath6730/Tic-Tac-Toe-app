// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:tic_tac_toe/services/socket_service.dart';
// import 'package:tic_tac_toe/utilities/enums.dart';
// import 'package:tic_tac_toe/utilities/online_play_classes.dart';
// import 'package:tic_tac_toe/utilities/show_snackbar.dart';
// import 'package:tic_tac_toe/utilities/utlility.dart';

// import './../models/logic_provider.dart';

// class PlayOnlineProvider extends LogicProvider with ChangeNotifier {
//   // io.Socket socket =
//   //     io.io("https://bharath6730.herokuapp.com/", <String, dynamic>{
//   //   "transports": ["websocket"],
//   //   "autoConnect": false,
//   // });

//   static const token2 =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTdlMGE1YTlkMDRkN2IzYzFhMTkwNSIsImlhdCI6MTY3MjEzMjUzM30.HsniUysmMaRK362sQirGDWAhjQysoo9mD-2MoMq1BmM";
//   static const token =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYTk4ODRlOTdiNWI4NGUxY2I3MDU1MCIsImlhdCI6MTY3MjA1NDg2Mn0.pPH--nfe-ZsGp-aCTpCIdLJF1Y21N1P6wkmDyiBgcJQ";
//   io.Socket socket = SocketService().socketInstance;

//   BuildContext context;
//   late String myName;
//   String opponentName = "Opponent";
//   GameState _gameState = GameState.idle;

//   String? room;
//   bool connected = false;
//   bool iAmPlayer1 = true;
//   Player myButtonType = Player.X;

//   bool didIWIn = false;
//   bool didIStartFirst = false;
//   bool myTurnCopy = false;
//   bool winnerDialogAlreadyShown = false;
//   bool opponentWantsToPlayAgain = false;

//   PlayOnlineProvider({
//     required this.context,
//   }) : super(gameMode: GameMode.playOnline) {
//     connected = socket.connected;
//     initializeSocket();
//   }

//   void initializeSocket() {
//     // var newToken = (myName == "Bharath") ? token : token2;

//     // if (!socket.connected) {
//     //   print("Connecting :$connected");
//     //   socket.connect();
//     //   connected = socket.connected;
//     //   notifyListeners();
//     // }

//     socket.onConnectError((data) {
//       showSnackBar(context, "There was error .Please try again later.");
//     });

//     socket.onError((data) {
//       print(data);
//       print(socket.connected);
//     });

//     // socket.onConnect((data) {
//     //   connected = socket.connected;
//     //   notifyListeners();
//     //   socket.on("messageFromServer", (msg) {
//     //     Message string = Message.fromJson(msg);
//     //     showSnackBar(context, string.data);
//     //   });

//     //   socket.onDisconnect(((data) {
//     //     connected = socket.connected;
//     //     notifyListeners();
//     //     showSnackBar(context, "Disconnected from server");
//     //   }));

//     //   socket.emit("messageToServer", "Successfully connected.");
//     // });

//     // socket.on("gameCreated", (data) {
//     //   print("GameCreated" + data);
//     //   // roomMessage roomData = roomMessage.fromJson(data);
//     //   // myTurn = false;
//     //   // room = roomData.room;
//     //   // Navigator.of(context).pushNamed("/playOnlineGameScreen", arguments: this);
//     //   // changeGameState(GameState.waitingForPlayerToJoin);
//     // });

//     socket.on("p2Joined", (data) {
//       if (gameState == GameState.waitingForPlayerToJoin) {
//         GameMessage gameMessage = GameMessage.fromJson(data);
//         opponentName = gameMessage.player2 as String;
//         iAmPlayer1 = true;
//         myTurn = true;

//         socket.emit("p1Detail",
//             {"player1": myName, "player2": opponentName, "room": room});
//       } else if (gameState == GameState.waitingForPlayerToJoinAgain) {
//         myTurn = myTurnCopy;
//         // showPlayerLeftDialog = false;

//         List<String> xList = xButtons.map((e) => "0${e.toString()}").toList();
//         List<String> oList = oButtons.map((e) => "0${e.toString()}").toList();

//         socket.emit("allGameInfo", {
//           "xList": xList,
//           "oList": oList,
//           "myScore": xWinCount,
//           "TotalGames": xWinCount + tiesCount + oWinCount,
//           "draw": tiesCount,
//           "oppName": opponentName,
//           "Player": (myButtonType == Player.X) ? "X" : "O",
//           "myTurn": myTurn,
//           "player1": myName,
//           "room": room,
//         });
//       }
//       changeGameState(GameState.playing);
//     });

//     socket.on("p1Detail", (data) {
//       Navigator.of(context).pushNamed("/playOnlineGameScreen", arguments: this);

//       GameMessage gameMessage = GameMessage.fromJson(data);
//       room = gameMessage.room;
//       myButtonType = Player.O;
//       playerType = Player.O;
//       opponentName = gameMessage.player1 as String;

//       myTurn = false;
//       iAmPlayer1 = false;

//       changeGameState(GameState.playing);
//     });

//     socket.on("allGameInfo", (data) {
//       ReJoin rejoinMessage = ReJoin.fromJson(data);

//       opponentName = rejoinMessage.player1 as String;
//       room = rejoinMessage.room;
//       playerType = Player.X;
//       for (var element in rejoinMessage.xList!) {
//         element = int.parse(element);
//         super.onButtonClick(element);
//       }

//       playerType = Player.O;
//       for (var element in rejoinMessage.oList!) {
//         element = int.parse(element);
//         super.onButtonClick(element);
//       }

//       if (rejoinMessage.player == Player.X) {
//         xWinCount = rejoinMessage.myScore;
//         tiesCount = rejoinMessage.draw;
//         oWinCount = rejoinMessage.totalGames - tiesCount - xWinCount;
//         myButtonType = Player.O;
//         iAmPlayer1 = false;
//       } else {
//         tiesCount = rejoinMessage.draw;
//         oWinCount = rejoinMessage.myScore;
//         xWinCount = rejoinMessage.totalGames - tiesCount - oWinCount;
//         myButtonType = Player.X;
//         iAmPlayer1 = true;
//       }
//       myTurn = !rejoinMessage.myTurn;

//       changeGameState(GameState.playing);
//     });

//     socket.on("game", (data) {
//       GameMessage gameMessage = GameMessage.fromJson(data);
//       togglePlayer();

//       int id;
//       if (myButtonType == Player.X) {
//         id = gameMessage.Y as int;
//       } else {
//         id = gameMessage.X as int;
//       }
//       super.onButtonClick(id);

//       togglePlayer();
//       myTurn = true;

//       notifyListeners();
//     });

//     socket.on("winner", (data) {
//       WinnerMessage gameMessage = WinnerMessage.fromJson(data);
//       if (myButtonType == gameMessage.whoStarted) {
//         didIStartFirst = true;
//       } else {
//         didIStartFirst = false;
//       }
//       if (gameMessage.winner == "X") {
//         playerType = Player.X;
//         if (myButtonType != Player.X) {
//           super.onButtonClick(gameMessage.X as int);
//           didIWIn = false;
//         } else {
//           didIWIn = true;
//         }
//       } else if (gameMessage.winner == "O") {
//         playerType = Player.O;
//         if (myButtonType != Player.O) {
//           super.onButtonClick(gameMessage.Y as int);
//           didIWIn = false;
//         } else {
//           didIWIn = true;
//         }
//       } else {
//         if (gameMessage.X != null) {
//           playerType = Player.X;
//           super.onButtonClick(gameMessage.X as int);
//         } else {
//           playerType = Player.O;
//           super.onButtonClick(gameMessage.Y as int);
//         }
//       }

//       bool winners = super.checkWinner();

//       if (winners) {
//         myTurn = false;
//         showWinnerDialog = true;
//         playerType = myButtonType;
//       }
//       // if (winner == ButtonType.none) {
//       //   incrementKey("tie");
//       // } else if (winner ==
//       //     (myButtonType == Player.X ? ButtonType.X : ButtonType.O)) {
//       //   incrementKey("win");
//       // } else {
//       //   incrementKey("lose");
//       // }
//       notifyListeners();
//     });

//     socket.on("roomFull", (data) {
//       Message message = Message.fromJson(data);
//       showSnackBar(context, message.data);
//       changeGameState(GameState.idle);
//     });
//     socket.on("wrongRoom", (data) {
//       Message message = Message.fromJson(data);
//       showSnackBar(context, message.data);
//       changeGameState(GameState.idle);
//     });

//     socket.on("playerLeft", (_) {
//       showWinnerDialog = false;
//       // showPlayerLeftDialog = true;
//       myTurnCopy = myTurn;
//       myTurn = false;

//       changeGameState(GameState.opponentLeft);
//     });
//     socket.on("next-round", (_) {
      // if (gameState == GameState.waitingForNextRoundAcceptance) {
      //   playerType = myButtonType;
      //   if (didIStartFirst) {
      //     myTurn = false;
      //   } else {
      //     myTurn = true;
      //   }

      //   opponentWantsToPlayAgain = false;
      //   changeGameState(GameState.playing);
      // } else {
      //   opponentWantsToPlayAgain = true;
      // }
//       notifyListeners();
//     });
//     socket.on("quit", (data) {
//       changeGameState(GameState.opponentQuit);
//     });
//   }

//   void disconnectSocket() {
//     // socket.disconnect();
//     print("Exit");
//   }

//   void createGame() {
//     if (!connected) {
//       showSnackBar(
//           context, "Unable to connect server. Please try again later.");
//       return;
//     }
//     if (_gameState != GameState.idle) return;
//     changeGameState(GameState.creating);
//     socket.emit("createGame", {"shortLink": true});
//   }

//   void joinGame(String roomName) {
//     if (!connected) {
//       showSnackBar(
//           context, "Unable to connect server. Please try again later.");
//       return;
//     }
//     if (_gameState != GameState.idle) return;
//     changeGameState(GameState.joining);
//     socket.emit("joinGame", {"player2": myName, "room": roomName});
//   }

//   void waitForPlayer() {
//     // showPlayerLeftDialog = false;

//     changeGameState(GameState.waitingForPlayerToJoinAgain);
//   }

//   void changeModelToTrue() {
//     winnerDialogAlreadyShown = true;
//   }

//   void changeModelToFalse() {
//     winnerDialogAlreadyShown = false;
//   }

//   @override
//   bool onButtonClick(int id) {
//     if (winner != null) {
//       showWinnerDialog = true;
//       notifyListeners();
//       return false;
//     }

//     bool isChanged = false;
//     if (!myTurn) return isChanged;
//     playerType = myButtonType;
//     isChanged = super.onButtonClick(id);

//     if (!isChanged) return isChanged;

//     String myButton = (myButtonType == Player.X) ? "X" : "Y";
//     List<String> xList = xButtons.map((e) => "0${e.toString()}").toList();
//     List<String> oList = oButtons.map((e) => "0${e.toString()}").toList();
//     socket.emit("game",
//         {"room": room, myButton: "0$id", "xList": xList, "oList": oList});
//     myTurn = false;
//     notifyListeners();

//     return isChanged;
//   }

//   @override
//   void resetGame() {
//     super.resetGame();
//     if (!opponentWantsToPlayAgain) {
//       myTurn = false;
//       changeGameState(GameState.waitingForNextRoundAcceptance);
//     } else {
//       opponentWantsToPlayAgain = false;
//       playerType = myButtonType;
//       if (didIStartFirst) {
//         myTurn = false;
//       } else {
//         myTurn = true;
//       }
//       changeGameState(GameState.playing);
//     }
//     socket.emit("next-round", {"room": room});
//     changeModelToFalse();

//     notifyListeners();
//   }

//   get gameState {
//     return _gameState;
//   }

//   GameState changeGameState(GameState gameState) {
//     _gameState = gameState;
//     // print(_gameState);
//     notifyListeners();
//     return _gameState;
//   }

//   void quitGame() {
//     socket.emit("quit", {"room": room});
//     Navigator.of(context).popUntil(ModalRoute.withName('/playOnline'));

//     super.resetGame();
//     super.completeReset();

//     // this scope variables reset
//     room = null;
//     opponentName = "Opponent";

//     iAmPlayer1 = true;
//     myButtonType = Player.X;
//     didIWIn = false;
//     didIStartFirst = false;
//     myTurnCopy = false;
//     opponentWantsToPlayAgain = false;
//     winnerDialogAlreadyShown = false;

//     changeGameState(GameState.idle);
//   }
// }
