enum BoxColor { blue, yellow, grey, silver, dark, dialog, none }

enum GameMode { passAndPlay, playVsCPU, playOnline }

enum ButtonType { X, O, none }

enum WinnerType { X, O, draw, none }

enum Player { X, O }

enum GameState {
  idle,
  creating,
  joining,
  playing,
  waitingForPlayerToJoin,
  opponentLeft,
  waitingForPlayerToJoinAgain,
  waitingForNextRoundAcceptance,
  opponentQuit
}
