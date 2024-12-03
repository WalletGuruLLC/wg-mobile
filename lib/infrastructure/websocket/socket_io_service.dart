import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../domain/websocket/i_websocket_service.dart';
import '../core/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketIOService implements IWebSocketService {
  late IO.Socket socket;

  @override
  Future<void> connect() async {
    final storage = await SharedPreferences.getInstance();
    final String? token = storage.getString('Basic');
    socket = IO.io('${Env.baseUrlWs}/users-balance', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'Token': "Bearer $token"}
    });
    socket.connect();

    socket.onConnect((_) {
      debugPrint("Connection established");
    });
  }

  @override
  void disconnect() {
    debugPrint("disconnection...");
    socket.disconnect();
  }

  @override
  void sendMessage(String event, Map<String, dynamic> data) {
    socket.emit(event, data);
  }

  @override
  Stream<Map<String, dynamic>> onMessage(String event) {
    final controller = StreamController<Map<String, dynamic>>();

    socket.on(event, (data) {
      if (data is Map<String, dynamic>) {
        controller.add(data);
      } else {
        print('Received data is not of type Map<String, dynamic>');
      }
    });
    return controller.stream;
  }
}
