// lib/domain/entities/chat_message.dart
class ChatMessage {
  final String message;
  final bool isSentByMe;
  final DateTime timestamp;
  final bool isRead;

  ChatMessage({
    required this.message,
    required this.isSentByMe,
    required this.timestamp,
    this.isRead = false,
  });
}