import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_toe/models/user_model.dart';
import 'package:tic_tac_toe/services/socket_service.dart';
import 'package:tic_tac_toe/utilities/constants.dart';
import 'package:tic_tac_toe/utilities/enums.dart';
import 'package:tic_tac_toe/utilities/show_snackbar.dart';

import './../models/logic_provider.dart';

class PlayOnlineProvider extends LogicProvider with ChangeNotifier {
  // Socketio
  SocketService socketService = SocketService();
  late Socket socket = socketService.socketInstance;
  late bool connected = socket.connected;
  // late Stream<bool> connectionStream = socketService.connectionOnChangeStream;

  // Game
  BuildContext context;
  GameState _gameState = GameState.idle;
  late PublicUserData myDetails;
  late String room;
  PublicUserData opponentDetails = PublicUserData(
      name: "Opponent", profilePic: defaultImageUrl, publicId: "123");
  Player myButtonType = Player.X;
  Player opponentButtonType = Player.O;
  bool iAmPlayer1 = true;
  bool winnerDialogAlreadyShown = false;
  bool opponentWantsToPlayAgain = false;

  PlayOnlineProvider({required this.context, required this.myDetails})
      : super(gameMode: GameMode.playOnline) {
    initializeSocket();
  }

  void initializeSocket() {
    socket.on("connect", (data) {
      connected = true;
      notifyListeners();
    });
    socket.onDisconnect((data) {
      connected = false;
      showSnackBar(context, "Disconnected from server");
      notifyListeners();
    });

    socket.on("gameCreated", (data) {
      room = data['room'];
      myTurn = false;
      Navigator.of(context).pushNamed("/playOnlineGameScreen", arguments: this);
      changeGameState(GameState.waitingForPlayerToJoin);
    });

    socket.on("invalidRoom", (data) {
      showSnackBar(context, data['message']);
      changeGameState(GameState.idle);
    });

    socket.on("startGame", (data) {
      if (_gameState == GameState.waitingForPlayerToJoinAgain) {
        myTurn = data['whoseTurn'] == myDetails.publicId;
        changeGameState(GameState.playing);
        return;
      }
      room = data['gameRoom'];
      dynamic p1 = data['player1'];
      dynamic p2 = data['player2'];
      dynamic opponent;
      opponent = p1['publicId'] == myDetails.publicId ? p2 : p1;

      iAmPlayer1 = opponent == p2;
      myButtonType = iAmPlayer1
          ? data['p1Type'] == "X"
              ? Player.X
              : Player.O
          : data['p2Type'] == "X"
              ? Player.X
              : Player.O;

      int totalGames = data['totalGames'];
      int drawCount = data['drawCount'];
      int player1WinCount = data['player1WinCount'];
      int player2WinCount = (totalGames - (player1WinCount + drawCount));
      tiesCount = drawCount;
      if (iAmPlayer1) {
        xWinCount =
            (myButtonType == Player.X) ? player1WinCount : player2WinCount;
        oWinCount =
            (myButtonType == Player.X) ? player2WinCount : player1WinCount;
      } else {
        xWinCount =
            (myButtonType == Player.X) ? player2WinCount : player1WinCount;
        oWinCount =
            (myButtonType == Player.X) ? player1WinCount : player2WinCount;
      }
      var xList = data['xList'].whereType<int>().toList();
      var oList = data['oList'].whereType<int>().toList();
      checkAndFillGameButton(xList, oList);

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

    socket.on("game", (data) {
      playerType = myButtonType == Player.X ? Player.O : Player.X;
      super.onButtonClick(data['move']);
      myTurn = true;

      notifyListeners();
    });

    socket.on("winner", (data) {
      playerType = data['winner'] == "O" ? Player.O : Player.X;
      super.onButtonClick(data['move']);

      bool winnerExists = super.checkWinner();
      if (winnerExists) {
        myTurn = false;
        showWinnerDialog = true;
      }

      notifyListeners();
    });
    socket.on("nextRound", (_) {
      opponentWantsToPlayAgain = true;
      notifyListeners();
    });
    socket.on("startNextRound", (data) {
      opponentWantsToPlayAgain = false;
      myTurn = data['whoseTurn'] == myDetails.publicId;
      changeGameState(GameState.playing);
      notifyListeners();
    });
    socket.on("playerLeft", (_) {
      showWinnerDialog = false;
      myTurn = false;

      changeGameState(GameState.opponentLeft);
    });
    socket.on("quit", (_) {
      changeGameState(GameState.opponentQuit);
    });
    socket.on("gameError", (data) => print(data));
  }

  void disconnectSocket() {
    socket.off("gameCreated");
    socket.off("gameError");
    socket.off("startGame");
    socket.off("invalidRoom");
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
    changeGameState(GameState.waitingForPlayerToJoinAgain);
  }

  void changeModelToTrue() {
    winnerDialogAlreadyShown = true;
  }

  void changeModelToFalse() {
    winnerDialogAlreadyShown = false;
  }

  @override
  bool onButtonClick(int id) {
    if (winner != WinnerType.none) {
      showWinnerDialog = true;
      notifyListeners();
      return false;
    }

    bool isChanged = false;
    if (!myTurn) return isChanged;
    playerType = myButtonType;
    isChanged = super.onButtonClick(id);

    if (!isChanged) return isChanged;

    socket.emit("game", {"move": id});
    myTurn = false;
    notifyListeners();

    return isChanged;
  }

  @override
  void resetGame() {
    super.resetGame();
    myTurn = false;
    socket.emit("nextRound", {"data": "message"});
    if (opponentWantsToPlayAgain) {
      changeGameState(GameState.playing);
    } else {
      changeGameState(GameState.waitingForNextRoundAcceptance);
    }
    changeModelToFalse();

    notifyListeners();
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
    if (_gameState == GameState.playing) {
      socket.emit("quit");
    }
    Navigator.of(context).popUntil(ModalRoute.withName('/playOnline'));

    super.resetGame();
    super.completeReset();

    // // this scope variables reset
    room = "";
    opponentDetails = PublicUserData(
        name: "Opponent", profilePic: "public.url", publicId: "124");
    iAmPlayer1 = true;
    myButtonType = Player.X;
    opponentWantsToPlayAgain = false;
    winnerDialogAlreadyShown = false;

    changeGameState(GameState.idle);
  }

  void exit() {}

  void handleConnectionChange(connectionStatus) {
    print("ConnectionChanged : $connectionStatus");
  }

  bool amiWinner() {
    if (winner == WinnerType.X && myButtonType == Player.X) return true;
    if (winner == WinnerType.O && myButtonType == Player.O) return true;
    return false;
  }

  void checkAndFillGameButton(List<int> xList, List<int> oList) {
    if (xList.isEmpty && oList.isEmpty) return;

    playerType = Player.X;
    xList.forEach((element) {
      super.onButtonClick(element);
    });
    playerType = Player.O;
    oList.forEach((element) {
      super.onButtonClick(element);
    });
  }
}
