import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/models/user_model.dart';
import 'package:tic_tac_toe/services/socket_service.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';

import './../models/logic_provider.dart';

class PlayOnlineProvider extends LogicProvider with ChangeNotifier {
  // Socketio
  SocketService socketService = SocketService();
  late Socket socket = socketService.socketInstance;
  late bool connected = socketService.connectionStatus;
  // late Stream<bool> connectionStream = socketService.connectionOnChangeStream;

  // Game
  static const publicLink =
      'https://res.cloudinary.com/dciwowqk7/image/upload/v1660972618/user/default-profile-pic.jpg';
  GameState _gameState = GameState.idle;
  BuildContext context;
  late final PublicUserData myDetails;
  late final String room;
  PublicUserData opponentDetails =
      PublicUserData(name: "Opponent", profilePic: "temp", publicId: "asd");
  Player myButtonType = Player.X;
  Player opponentButtonType = Player.O;
  bool iAmPlayer1 = true;
  bool didIWIn = false;
  bool didIStartFirst = false;
  bool myTurnCopy = false;
  bool winnerDialogAlreadyShown = false;
  bool opponentWantsToPlayAgain = false;

  PlayOnlineProvider({required this.context, required this.myDetails})
      : super(gameMode: GameMode.playOnline) {
    initializeSocket();
  }

  void initializeSocket() {
    // connectionStream.listen((event) => handleConnectionChange);
    socket.on("gameCreated", (data) {
      print(data['room']);
      room = data['room'];
      Navigator.of(context).pushNamed("/playOnlineGameScreen", arguments: this);
      changeGameState(GameState.waitingForPlayerToJoin);
    });

    socket.on("startGame", (data) {
      dynamic p1 = data['player1'];
      dynamic p2 = data['player2'];
      dynamic opponent;
      opponent = p1['publicId'] == myDetails.publicId ? p2 : p1;
      iAmPlayer1 = opponent == p2;
      myTurn = data['whoseTurn'] == myDetails.publicId;
      opponentDetails = PublicUserData(
          name: opponent['username'],
          profilePic: opponent['profilePic'],
          publicId: opponent['publicId']);

      if (gameState == GameState.joining) {
        Navigator.of(context)
            .pushNamed("/playOnlineGameScreen", arguments: this);
      }
      changeGameState(GameState.playing);
    });
  }

  void disconnectSocket() {
    // socket.disconnect();
    print("Exit");
  }

  void createGame() {
    if (!connected) {
      showSnackBar(
          context, "Unable to connect server. Please try again later.");
      return;
    }
    if (_gameState != GameState.idle) return;
    changeGameState(GameState.creating);
    socket.emit("createGame", {"shortLink": true});
  }

  void joinGame(String roomName) {
    if (!connected) {
      showSnackBar(
          context, "Unable to connect server. Please try again later.");
      return;
    }
    if (_gameState != GameState.idle) return;
    changeGameState(GameState.joining);
    socket.emit("joinGame", {"room": roomName});
  }

  void waitForPlayer() {
    // showPlayerLeftDialog = false;

    // changeGameState(GameState.waitingForPlayerToJoinAgain);
  }

  void changeModelToTrue() {
    // winnerDialogAlreadyShown = true;
  }

  void changeModelToFalse() {
    // winnerDialogAlreadyShown = false;
  }

  @override
  bool onButtonClick(int id) {
    // if (winner != WinnerType.none) {
    //   showWinnerDialog = true;
    //   notifyListeners();
    //   return false;
    // }

    // bool isChanged = false;
    // if (!myTurn) return isChanged;
    // playerType = myButtonType;
    // isChanged = super.onButtonClick(id);

    // if (!isChanged) return isChanged;

    // String myButton = (myButtonType == Player.X) ? "X" : "Y";
    // List<String> xList = xButtons.map((e) => "0${e.toString()}").toList();
    // List<String> oList = oButtons.map((e) => "0${e.toString()}").toList();
    // socket.emit("game",
    //     {"room": room, myButton: "0$id", "xList": xList, "oList": oList});
    // myTurn = false;
    // notifyListeners();

    // return isChanged;
    return true;
  }

  @override
  void resetGame() {
    // super.resetGame();
    // if (!opponentWantsToPlayAgain) {
    //   myTurn = false;
    //   changeGameState(GameState.waitingForNextRoundAcceptance);
    // } else {
    //   opponentWantsToPlayAgain = false;
    //   playerType = myButtonType;
    //   if (didIStartFirst) {
    //     myTurn = false;
    //   } else {
    //     myTurn = true;
    //   }
    //   changeGameState(GameState.playing);
    // }
    // socket.emit("next-round", {"room": room});
    // changeModelToFalse();

    // notifyListeners();
  }

  get gameState {
    return _gameState;
  }

  GameState changeGameState(GameState gameState) {
    _gameState = gameState;
    notifyListeners();
    return _gameState;
  }

  void quitGame() {
    socket.emit("quit", {"room": room});
    Navigator.of(context).popUntil(ModalRoute.withName('/playOnline'));

    super.resetGame();
    super.completeReset();

    // // this scope variables reset
    // room = null;
    // opponentName = "Opponent";

    // iAmPlayer1 = true;
    // myButtonType = Player.X;
    // didIWIn = false;
    // didIStartFirst = false;
    // myTurnCopy = false;
    // opponentWantsToPlayAgain = false;
    // winnerDialogAlreadyShown = false;

    // changeGameState(GameState.idle);
  }

  void exit() {}

  handleConnectionChange(connectionStatus) {
    print("ConnectionChanged : $connectionStatus");
  }
}
