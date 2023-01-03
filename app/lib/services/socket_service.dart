import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _socketService = SocketService._internal();

  SocketService._internal();

  factory SocketService() {
    return _socketService;
  }

  final StreamController<bool> _connectionStatusStream =
      StreamController<bool>();

  final io.Socket _socket =
      io.io("http://192.168.1.174:3000/", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  bool connected = false;

  io.Socket get socketInstance => _socket;

  bool get connectionStatus => _socket.connected;
  Stream<bool> get connectionOnChangeStream =>
      _connectionStatusStream.stream.asBroadcastStream();

  init(token) async {
    _socket.auth = {"token": token};
    if (!connected) {
      _socket.connect();
      print(_socket.connected);
      print(connected);
    }

    _socket.on("connect", (_) {
      _connectionStatusStream.add(true);
      connected = _socket.connected;
    });
    _socket.on("test", (data) => print(data));
    _socket.onError((data) => print("Error : $data"));
    _socket.onConnectError((data) => print("ConnectError : $data"));
    _socket.onDisconnect((data) {
      connected = false;
      _connectionStatusStream.add(false);
    });
  }
}
