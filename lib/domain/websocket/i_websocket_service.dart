abstract class IWebSocketService {
  Future<void> connect();
  void disconnect();
  void sendMessage(String event, Map<String, dynamic> data);
  Stream<Map<String, dynamic>> onMessage(String event);
}
