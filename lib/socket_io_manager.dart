import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOManager {
  late IO.Socket socket;

  void initializeSocket() {
    socket = IO.io(
        'https://d415-186-112-240-36.ngrok-free.app/users-balance',
        <String, dynamic>{
          'transports': ['websocket'],
          //'autoConnect': true,
          'extraHeaders': {
            'Token':
                '3f3dbb27bb91ea91db1f183055bff86064103ca2dcbb2a92d1986ab423ee53e3'
          }
        });

    //socket.onConnect((_) {
    //  print('Connection established');
    //});

    socket.on('hc', (data) => print(data));
    socket.on('balance', (data) => print(data));
    socket.on('error', (data) => print(data));

    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    //socket.onDisconnect((_) => print('Connection Disconnection'));
    //socket.onConnectError((err) => print('Connect Error: $err'));
    //socket.onError((err) => print('Error: $err'));

    //socket.connect();
    socket.on('connect', (_) {
      print('connect');
      Map<String, dynamic> message = {"hola": "hola"};
      socket.emit('balance', message);
      //socket.emit('msg', 'test');
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
