import 'package:tic_tac_toe/utilities/utlility.dart';

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

class ReJoin extends GameMessage {
  int totalGames;
  int myScore;
  int draw;
  bool myTurn;
  Player player;
  String oppName;

  ReJoin(
      {required super.room,
      super.oList,
      super.xList,
      super.player1,
      super.player2,
      required this.totalGames,
      required this.myTurn,
      required this.player,
      required this.oppName,
      required this.draw,
      required this.myScore});

  factory ReJoin.fromJson(Map<String, dynamic> json) {
    // print(json);
    return ReJoin(
        room: json["room"],
        player2: json["player2"],
        oList: json["oList"],
        xList: json["xList"],
        player1: json["player1"],
        draw: json["draw"],
        myScore: json["myScore"],
        myTurn: json["myTurn"],
        oppName: json["oppName"],
        player: (json["Player"] == "X") ? Player.X : Player.O,
        totalGames: json["TotalGames"]);
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
