import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tic_tac_toe/utilities/constants.dart';

enum SocketConnection { connected, offline }

class SocketService {
  static final SocketService _socketService = SocketService._internal();

  SocketService._internal();

  factory SocketService() {
    return _socketService;
  }

  final StreamController<SocketConnection> _connectionStatusStream =
      StreamController<SocketConnection>();

  final io.Socket _socket = io.io(backendUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  SocketConnection _connected = SocketConnection.offline;

  io.Socket get socketInstance => _socket;

  SocketConnection get connectionStatus => _connected;
  Stream<SocketConnection> get connectionOnChangeStream =>
      _connectionStatusStream.stream;

  init(token) async {
    _socket.auth = {"token": token};
    if (!_socket.connected) {
      _socket.connect();
    }

    _socket.on("connect", (_) {
      _connectionStatusStream.add(SocketConnection.connected);
      _connected = SocketConnection.connected;
    });
    _socket.on("test", (data) => print(data));
    _socket.onError((data) => print("Error : $data"));
    _socket.onConnectError((data) => print("ConnectError : $data"));
    _socket.onDisconnect((data) {
      _connected = SocketConnection.offline;
      _connectionStatusStream.add(SocketConnection.offline);
    });
  }
}
