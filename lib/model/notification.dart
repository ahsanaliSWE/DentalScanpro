class NotificationMessage {
  final String? title;
  final String? body;
  final DateTime timestamp;
  final String source; // E.g., 'reminder' or 'push'

  NotificationMessage({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.source,
  });
}
