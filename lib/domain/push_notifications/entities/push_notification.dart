class PushNotification {
  final String title;
  final String body;
  final Map<String, dynamic>? data;

  PushNotification({required this.title, required this.body, this.data});
}